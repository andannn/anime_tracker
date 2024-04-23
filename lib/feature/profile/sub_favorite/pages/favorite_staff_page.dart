import 'package:aniflow/app/aniflow_router/ani_flow_router_delegate.dart';
import 'package:aniflow/core/common/util/global_static_constants.dart';
import 'package:aniflow/core/data/model/staff_character_name_model.dart';
import 'package:aniflow/core/data/model/staff_model.dart';
import 'package:aniflow/core/design_system/widget/media_preview_item.dart';
import 'package:aniflow/core/paging/page_loading_state.dart';
import 'package:aniflow/core/paging/paging_content_widget.dart';
import 'package:aniflow/core/shared_preference/aniflow_preferences.dart';
import 'package:aniflow/feature/profile/sub_favorite/bloc/favorite_staff_paging_bloc.dart';
import 'package:aniflow/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteStaffListPage extends Page {
  const FavoriteStaffListPage({super.key, required this.userId});

  final String userId;

  @override
  Route createRoute(BuildContext context) {
    return FavoriteStaffListRoute(settings: this, userId: userId);
  }
}

class FavoriteStaffListRoute extends PageRoute
    with MaterialRouteTransitionMixin {
  FavoriteStaffListRoute({
    super.settings,
    required this.userId,
  }) : super(allowSnapshotting: false);
  final String userId;

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<FavoriteStaffPagingBloc>(
        param1: userId,
        param2: AfConfig.defaultPerPageCount,
      ),
      child: const _FavoriteStaffListPageContent(),
    );
  }

  @override
  bool get maintainState => true;
}

class _FavoriteStaffListPageContent extends StatelessWidget {
  const _FavoriteStaffListPageContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteStaffPagingBloc, PagingState<List<StaffModel>>>(
        builder: (context, state) {
      final pagingState = state;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Favorite staffs'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.maybePop(context);
            },
          ),
        ),
        body: PagingContent<StaffModel, FavoriteStaffPagingBloc>(
          pagingState: pagingState,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 3.0 / 5.2,
          ),
          onBuildItem: (context, model) => _buildListItems(context, model),
        ),
      );
    });
  }

  Widget _buildListItems(BuildContext context, StaffModel model) {
    final language =
        getIt.get<AniFlowPreferences>().aniListSettings.value.userStaffNameLanguage;
    return MediaPreviewItem(
      coverImage: model.mediumImage,
      title: model.name!.getNameByUserSetting(language),
      textStyle: Theme.of(context).textTheme.labelMedium,
      onClick: () {
        AfRouterDelegate.of(context).backStack.navigateToDetailStaff(model.id);
      },
    );
  }
}
