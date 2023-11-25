import 'package:aniflow/app/local/util/string_resource_util.dart';
import 'package:aniflow/core/common/model/staff_language.dart';
import 'package:aniflow/core/data/media_information_repository.dart';
import 'package:aniflow/core/data/model/character_and_voice_actor_model.dart';
import 'package:aniflow/core/design_system/widget/character_and_voice_actor_widget.dart';
import 'package:aniflow/core/design_system/widget/popup_menu_anchor.dart';
import 'package:aniflow/feature/character_page/bloc/character_page_bloc.dart';
import 'package:aniflow/feature/character_page/bloc/character_paging_bloc.dart';
import 'package:aniflow/feature/common/page_loading_state.dart';
import 'package:aniflow/feature/common/paging_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterListPage extends Page {
  final String animeId;

  const CharacterListPage({required this.animeId, super.key});

  @override
  Route createRoute(BuildContext context) {
    return CharacterListRoute(settings: this, animeId: animeId);
  }
}

class CharacterListRoute extends PageRoute with MaterialRouteTransitionMixin {
  final String animeId;

  CharacterListRoute({required this.animeId, super.settings})
      : super(allowSnapshotting: false);

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(
      create: (context) => CharacterPageBloc(),
      child: _CharacterPageContent(animeId: animeId),
    );
  }

  @override
  bool get maintainState => true;
}

class _CharacterPageContent extends StatelessWidget {
  const _CharacterPageContent({required this.animeId});

  final String animeId;

  @override
  Widget build(BuildContext context) {
    final staffLanguage = context.watch<CharacterPageBloc>().state.language;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
        actions: [
          PopupMenuAnchor(
            menuItems: StaffLanguage.values,
            builder: (context, controller, child) {
              return TextButton.icon(
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                icon: const Icon(Icons.filter_alt),
                label: Text(
                  staffLanguage.label(context),
                ),
              );
            },
            menuItemBuilder: (context, item) {
              return MenuItemButton(
                child: Container(
                  constraints: const BoxConstraints(minWidth: 80),
                  child: Text(item.label(context)),
                ),
                onPressed: () {
                  context
                      .read<CharacterPageBloc>()
                      .add(OnStaffLanguageChanged(staffLanguage: item));
                },
              );
            },
          )
        ],
      ),
      body: _CharacterPagingBlocProvider(
        key: ValueKey(
            // ignore: lines_longer_than_80_chars
            'character_paging_with_staff_language_${staffLanguage}_and_anime_id_$animeId'),
        staffLanguage: staffLanguage,
        animeId: animeId,
      ),
    );
  }
}

class _CharacterPagingBlocProvider extends StatelessWidget {
  const _CharacterPagingBlocProvider(
      {required super.key, required this.animeId, required this.staffLanguage});

  final String animeId;
  final StaffLanguage staffLanguage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CharacterPagingBloc(
        animeId,
        staffLanguage,
        aniListRepository: context.read<MediaInformationRepository>(),
      ),
      child: const _CharacterListPagingContent(),
    );
  }
}

class _CharacterListPagingContent extends StatelessWidget {
  const _CharacterListPagingContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterPagingBloc,
            PagingState<List<CharacterAndVoiceActorModel>>>(
        builder: (context, state) {
      final pagingState = state;
      return PagingContent<CharacterAndVoiceActorModel, CharacterPagingBloc>(
        pagingState: pagingState,
        onBuildItem: (context, model) => _buildListItems(context, model),
      );
    });
  }

  Widget _buildListItems(
      BuildContext context, CharacterAndVoiceActorModel model) {
    return SizedBox(
      height: 124,
      child: CharacterAndVoiceActorWidget(
        model: model,
        textStyle: Theme.of(context).textTheme.labelMedium,
        onCharacterTap: () {},
        onVoiceActorTop: () {},
      ),
    );
  }
}
