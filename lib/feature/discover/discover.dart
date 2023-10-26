import 'package:aniflow/app/local/ani_flow_localizations.dart';
import 'package:aniflow/app/navigation/ani_flow_router.dart';
import 'package:aniflow/core/common/model/anime_category.dart';
import 'package:aniflow/core/common/model/media_type.dart';
import 'package:aniflow/core/common/util/global_static_constants.dart';
import 'package:aniflow/core/data/model/media_model.dart';
import 'package:aniflow/core/data/model/media_title_modle.dart';
import 'package:aniflow/core/design_system/widget/avatar_icon.dart';
import 'package:aniflow/core/design_system/widget/loading_indicator.dart';
import 'package:aniflow/core/design_system/widget/media_preview_item.dart';
import 'package:aniflow/feature/auth/auth_dialog.dart';
import 'package:aniflow/feature/common/page_loading_state.dart';
import 'package:aniflow/feature/discover/bloc/discover_bloc.dart';
import 'package:aniflow/feature/discover/bloc/discover_ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscoverPage extends Page {
  const DiscoverPage({super.key});

  @override
  Route createRoute(BuildContext context) {
    return DiscoverPageRoute(settings: this);
  }
}

class DiscoverPageRoute extends PageRoute with MaterialRouteTransitionMixin {
  DiscoverPageRoute({super.settings}) : super(allowSnapshotting: false);

  @override
  Widget buildContent(BuildContext context) {
    return const DiscoverScreen();
  }

  @override
  bool get maintainState => true;
}

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscoverBloc, DiscoverUiState>(
      builder: (BuildContext context, state) {
        final map = state.categoryMediaMap;
        final currentMediaType = state.currentMediaType;

        final userData = state.userData;
        final isLoggedIn = state.isLoggedIn;
        final isLoading = state.isLoading;
        return Scaffold(
          appBar: AppBar(
            title: Text(AFLocalizations.of(context).discover),
            actions: [
              LoadingIndicator(isLoading: isLoading),
              IconButton(
                onPressed: () {
                  AFRouterDelegate.of(context).navigateToSearch();
                },
                icon: const Icon(Icons.search_rounded),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: IconButton(
                  onPressed: () => showAuthDialog(context),
                  icon: isLoggedIn
                      ? buildAvatarIcon(context, userData!.avatar)
                      : const Icon(Icons.person_outline),
                ),
              )
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await context.read<DiscoverBloc>().onPullToRefreshTriggered();
            },
            child: CustomScrollView(
              cacheExtent: Config.defaultCatchExtend,
              slivers:
                  _buildCategoriesByMediaType(context, map, currentMediaType),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildCategoriesByMediaType(
    BuildContext context,
    Map categoryMap,
    MediaType type,
  ) {
    final categories = MediaCategory.getALlCategoryByType(type)
        .map(
          (category) => _buildMediaCategoryPreview(
            context,
            category,
            categoryMap[category],
          ),
        )
        .toList();

    final widgets = <Widget>[];
    for (var i = 0; i < categories.length; i++) {
      widgets.add(categories[i]);
      if (i > 0 && i < (categories.length - 1)) {
        widgets.add(
          const SliverToBoxAdapter(
            child: SizedBox(height: 12),
          ),
        );
      }
    }
    return widgets;
  }

  Widget _buildMediaCategoryPreview(
    BuildContext context,
    MediaCategory category,
    PagingState state,
  ) {
    final animeModels = state.data;
    final isLoading = state is PageLoading;
    return SliverToBoxAdapter(
      child: _MediaCategoryPreview(
        category: category,
        animeModels: animeModels,
        isLoading: isLoading,
        onMoreClick: () {
          AFRouterDelegate.of(context).navigateToAnimeList(category);
        },
        onAnimeClick: (id) {
          AFRouterDelegate.of(context).navigateToDetailMedia(id);
        },
      ),
    );
  }
}

class _MediaCategoryPreview extends StatelessWidget {
  const _MediaCategoryPreview(
      {required this.category,
      required this.animeModels,
      required this.isLoading,
      this.onMoreClick,
      this.onAnimeClick});

  final MediaCategory category;
  final bool isLoading;
  final List<MediaModel> animeModels;
  final VoidCallback? onMoreClick;
  final Function(String animeId)? onAnimeClick;

  @override
  Widget build(BuildContext context) {
    Widget itemBuilder(MediaModel model) {
      return MediaPreviewItem(
        width: 160,
        textStyle: Theme.of(context).textTheme.titleSmall,
        coverImage: model.coverImage,
        title: model.title!.getLocalTitle(context),
        isFollowing: model.isFollowing,
        titleVerticalPadding: 5,
        onClick: () => onAnimeClick?.call(model.id),
      );
    }

    return Column(children: [
      _buildTitleBar(context),
      const SizedBox(height: 4),
      Container(
        child: isLoading && animeModels.isEmpty
            ? Container(
                constraints: const BoxConstraints(maxHeight: 260),
                child: _buildLoadingDummyWidget(),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children:
                          animeModels.map((item) => itemBuilder(item)).toList(),
                    ),
                  ),
                ),
              ),
      ),
    ]);
  }

  Widget _buildTitleBar(BuildContext context) {
    String title = category.getMediaCategoryTitle(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const Expanded(flex: 1, child: SizedBox()),
        TextButton(onPressed: onMoreClick, child: const Text('More')),
      ]),
    );
  }

  Widget _buildLoadingDummyWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.surfaceVariant,
            clipBehavior: Clip.antiAlias,
            child: const SizedBox(width: 160, height: 280),
          );
        },
      ),
    );
  }
}
