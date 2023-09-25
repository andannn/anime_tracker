import 'package:anime_tracker/core/network/api/ani_auth_mution_graphql.dart';
import 'package:anime_tracker/core/network/api/ani_save_media_list_mution_graphql.dart';
import 'package:anime_tracker/core/network/client/ani_list_dio.dart';
import 'package:anime_tracker/core/network/util/http_status_util.dart';
import 'package:anime_tracker/core/shared_preference/user_data.dart';
import 'package:dio/dio.dart';
import 'package:anime_tracker/core/common/global_static_constants.dart';
import 'package:anime_tracker/core/data/logger/logger.dart';
import 'package:anime_tracker/core/network/model/user_data_dto.dart'
    show UserDataDto;

class AuthDataSource {
  static AuthDataSource? _instance;

  factory AuthDataSource() => _instance ??= AuthDataSource._();

  AuthDataSource._();

  String _testToken = '';

  void setTestToken(String token) {
    _testToken = token;
  }

  String? get _token =>
      isUnitTest ? _testToken : AniFlowPreferences().getAuthToken();

  Future<bool> isTokenValid() async {
    if (_token == null) {
      return false;
    }

    try {
      await AniListDio().dio.post(
            AniListDio.aniListUrl,
            queryParameters: {'query': authCheckMotion},
            options: Options(
              headers: {
                'Authorization': 'Bearer $_token',
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
            ),
          );
    } on DioException catch (e) {
      if (e.response?.statusCode == StatusCode.unauthorized) {
        logger.d('token is expired');
      }
      return false;
    }

    return true;
  }

  Future<UserDataDto> getUserDataDto() async {
    final response = await AniListDio().dio.post(
          AniListDio.aniListUrl,
          queryParameters: {'query': createUserInfoMotionGraphQLString()},
          options: _createQueryOptions(),
        );

    final resultJson = response.data['data']['UpdateUser'];
    return UserDataDto.fromJson(resultJson);
  }

  Future saveAnimeToAnimeList(MediaListMutationParam param) async {
    final variablesMap = <String, dynamic>{
      'mediaId': param.mediaId,
    };
    if (param.entryId != null) {
      variablesMap['id'] = param.entryId;
    }
    if (param.progress != null) {
      variablesMap['progress'] = param.progress;
    }
    if (param.status != null) {
      variablesMap['status'] = param.status!.sqlTypeString;
    }
    if (param.status != null) {
      variablesMap['score'] = param.score;
    }

    try {
      await AniListDio().dio.post(
        AniListDio.aniListUrl,
        data: {
          'query': createSaveMediaListMotionGraphQLString(),
          'variables': variablesMap,
        },
        options: _createQueryOptions(),
      );
    } on DioException catch (e) {
      throw e.covertToNetWorkException();
    }
  }

  Options _createQueryOptions() {
    return Options(
      headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }
}
