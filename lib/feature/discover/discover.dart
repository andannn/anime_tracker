import 'package:anime_tracker/core/data/model/anime_model.dart';
import 'package:anime_tracker/core/data/model/page_loading_state.dart';
import 'package:anime_tracker/core/data/repository/ani_list_repository.dart';
import 'package:anime_tracker/core/design_system/animetion/page_transaction_animetion.dart';
import 'package:anime_tracker/core/design_system/widget/anime_preview_item.dart';
import 'package:anime_tracker/core/design_system/widget/avatar_icon.dart';
import 'package:anime_tracker/feature/discover/bloc/discover_bloc.dart';
import 'package:anime_tracker/feature/discover/bloc/discover_ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anime_tracker/app/local/ani_flow_localizations.dart';
import 'package:anime_tracker/app/navigation/ani_flow_router.dart';
import 'package:anime_tracker/feature/auth/auth_dialog.dart';
import 'package:anime_tracker/core/common/global_static_constants.dart';

class DiscoverPage extends Page {
  const DiscoverPage({super.key});

  @override
  Route createRoute(BuildContext context) {
    return DiscoverPageRoute(settings: this);
  }
}

class DiscoverPageRoute extends PageRoute with MaterialRouteTransitionMixin {
  DiscoverPageRoute({super.settings});

  @override
  Widget buildContent(BuildContext context) {
    return const Scaffold(body: DiscoverScreen());
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return getSecondaryPageTransaction(
      animation: secondaryAnimation,
      child: child,
    );
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
        final currentSeasonState = state.currentSeasonAnimePagingState;
        final nextSeasonState = state.nextSeasonAnimePagingState;
        final trendingState = state.trendingAnimePagingState;
        final movieState = state.movieAnimePagingState;
        final trackedAnimeIds = state.trackedAnimeIds;
        final userData = state.userData;
        final isLoggedIn = state.isLoggedIn;
        return RefreshIndicator(
          onRefresh: () async {
            await context.read<DiscoverBloc>().refreshAnime();
          },
          child: CustomScrollView(
            cacheExtent: Config.defaultCatchExtend,
            slivers: [
              SliverAppBar(
                title: Text(AFLocalizations.of(context).discover),
                pinned: true,
                actions: [
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
              SliverToBoxAdapter(
                child: _buildAnimeCategoryPreview(
                  context,
                  AnimeCategory.currentSeason,
                  currentSeasonState,
                  trackedAnimeIds,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 12),
              ),
              SliverToBoxAdapter(
                child: _buildAnimeCategoryPreview(
                  context,
                  AnimeCategory.nextSeason,
                  nextSeasonState,
                  trackedAnimeIds,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 12),
              ),
              SliverToBoxAdapter(
                child: _buildAnimeCategoryPreview(
                  context,
                  AnimeCategory.trending,
                  trendingState,
                  trackedAnimeIds,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),
              SliverToBoxAdapter(
                child: _buildAnimeCategoryPreview(
                  context,
                  AnimeCategory.movie,
                  movieState,
                  trackedAnimeIds,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnimeCategoryPreview(
    BuildContext context,
    AnimeCategory category,
    PagingState state,
    Set<String> trackedAnimeIds,
  ) {
    final animeModels = state.data;
    final isLoading = state is PageLoading;
    return _AnimeCategoryPreview(
      category: category,
      animeModels: animeModels,
      isLoading: isLoading,
      trackedAnimeIds: trackedAnimeIds,
      onMoreClick: () {
        AnimeTrackerRouterDelegate.of(context).navigateToAnimeList(category);
      },
      onAnimeClick: (id) {
        AnimeTrackerRouterDelegate.of(context).navigateToDetailAnime(id);
      },
    );
  }
}

class _AnimeCategoryPreview extends StatelessWidget {
  const _AnimeCategoryPreview(
      {required this.category,
      required this.animeModels,
      required this.isLoading,
      required this.trackedAnimeIds,
      this.onMoreClick,
      this.onAnimeClick});

  final AnimeCategory category;
  final bool isLoading;
  final List<AnimeModel> animeModels;
  final VoidCallback? onMoreClick;
  final Function(String animeId)? onAnimeClick;
  final Set<String> trackedAnimeIds;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _buildTitleBar(context),
      const SizedBox(height: 4),
      Container(
        constraints: const BoxConstraints(maxHeight: 280),
        child: isLoading && animeModels.isEmpty
            ? _buildLoadingDummyWidget()
            : CustomScrollView(scrollDirection: Axis.horizontal, slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  sliver: SliverList.builder(
                    itemCount: animeModels.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimePreviewItem(
                        width: 160,
                        textStyle: Theme.of(context).textTheme.titleSmall,
                        model: animeModels[index],
                        isTracking: trackedAnimeIds.contains(animeModels[index].id),
                        onClick: () =>
                            onAnimeClick?.call(animeModels[index].id),
                      );
                    },
                  ),
                ),
              ]),
      ),
    ]);
  }

  Widget _buildTitleBar(BuildContext context) {
    String title;
    switch (category) {
      case AnimeCategory.currentSeason:
        title = AFLocalizations.of(context).popularThisSeasonLabel;
      case AnimeCategory.nextSeason:
        title = AFLocalizations.of(context).upComingNextSeasonLabel;
      case AnimeCategory.trending:
        title = AFLocalizations.of(context).trendingNowLabel;
      case AnimeCategory.movie:
        title = AFLocalizations.of(context).movieLabel;
    }
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
