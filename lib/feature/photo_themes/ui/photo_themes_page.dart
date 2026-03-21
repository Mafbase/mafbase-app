import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/confirm_dialog.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dropdown.dart';
import 'package:seating_generator_web/common/widgets/fade_transition_page.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/feature/photo_themes/domain/models/photo_theme_model.dart';
import 'package:seating_generator_web/feature/photo_themes/ui/photo_themes_bloc.dart';
import 'package:seating_generator_web/feature/photo_themes/ui/photo_themes_bloc_injector.dart';
import 'package:seating_generator_web/feature/photo_themes/ui/photo_themes_event.dart';
import 'package:seating_generator_web/feature/photo_themes/ui/photo_themes_state.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_page.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:seating_generator_web/feature/photo_themes/ui/widgets/add_player_to_theme_widget.dart';
import 'package:seating_generator_web/feature/photo_themes/ui/widgets/photo_theme_card.dart';
import 'package:seating_generator_web/feature/photo_themes/ui/widgets/photo_theme_create_dialog.dart';
import 'package:seating_generator_web/feature/photo_themes/ui/widgets/photo_theme_player_cell.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_menu_action.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class PhotoThemesPage extends StatefulWidget {
  final int? tournamentId;

  const PhotoThemesPage({
    super.key,
    this.tournamentId,
  });

  @override
  State<PhotoThemesPage> createState() => _PhotoThemesPageState();

  static String createTournamentLocation({
    required int tournamentId,
    required BuildContext context,
  }) {
    return context.namedLocation(
      _tournamentName,
      pathParameters: {
        'id': tournamentId.toString(),
      },
    );
  }

  static const _tournamentName = 'tournament_photo_themes';
  static const _profileName = 'profile_photo_themes';

  static final GoRoute tournamentRoute = GoRoute(
    path: 'photo-themes',
    name: _tournamentName,
    builder: (context, state) {
      final tournamentId = int.parse(state.pathParameters['id']!);
      return PhotoThemesBlocInjector(
        key: ValueKey('photoThemes_$tournamentId'),
        tournamentId: tournamentId,
        child: PhotoThemesPage(tournamentId: tournamentId),
      );
    },
  );

  static final GoRoute profileRoute = GoRoute(
    path: '/photo-themes',
    name: _profileName,
    pageBuilder: (context, state) => FadeTransitionPage(
      child: const PhotoThemesBlocInjector(
        child: PhotoThemesPage(),
      ),
    ),
  );
}

class _PhotoThemesPageState extends CustomState<PhotoThemesPage> {
  bool get _isFromTournament => widget.tournamentId != null;

  Future<void> _pickAndUploadPhoto(
    BuildContext context,
    int themeId,
    int playerId,
  ) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final bytes = Uint8List.fromList(await image.readAsBytes());
    if (!context.mounted) return;
    context.read<PhotoThemesBloc>().add(
          PhotoThemesEventUploadPhoto(
            themeId: themeId,
            playerId: playerId,
            bytes: bytes,
            filename: image.name,
          ),
        );
  }

  void _onCreateTheme(BuildContext context) {
    PhotoThemeCreateDialog.show(context).then((name) {
      if (name != null && context.mounted) {
        context.read<PhotoThemesBloc>().add(
              PhotoThemesEventCreateTheme(name: name),
            );
      }
    });
  }

  void _onRenameTheme(BuildContext context, PhotoThemeModel theme) {
    PhotoThemeCreateDialog.show(context, initialName: theme.name).then((name) {
      if (name != null && context.mounted) {
        context.read<PhotoThemesBloc>().add(
              PhotoThemesEventRenameTheme(themeId: theme.id, name: name),
            );
      }
    });
  }

  void _onDeleteTheme(BuildContext context, int themeId) {
    ConfirmDialog.open(
      context,
      context.locale.photoThemesDeleteConfirm,
    ).then((confirmed) {
      if (confirmed == true && context.mounted) {
        context.read<PhotoThemesBloc>().add(
              PhotoThemesEventDeleteTheme(themeId: themeId),
            );
      }
    });
  }

  void _onDeletePhoto(BuildContext context, int themeId, int playerId) {
    ConfirmDialog.open(context).then((confirmed) {
      if (confirmed == true && context.mounted) {
        context.read<PhotoThemesBloc>().add(
              PhotoThemesEventDeletePhoto(
                themeId: themeId,
                playerId: playerId,
              ),
            );
      }
    });
  }

  void _onRemovePlayer(BuildContext context, int playerId) {
    ConfirmDialog.open(
      context,
      context.locale.photoThemesRemovePlayer,
    ).then((confirmed) {
      if (confirmed == true && context.mounted) {
        context.read<PhotoThemesBloc>().add(
              PhotoThemesEventRemovePlayer(playerId: playerId),
            );
      }
    });
  }

  void _onAddFromTournament(BuildContext context) {
    final tournamentId = widget.tournamentId;
    if (tournamentId == null) return;
    context.read<PhotoThemesBloc>().add(
          PhotoThemesEventAddFromTournament(tournamentId: tournamentId),
        );
  }

  Widget _buildPlayersGrid(
    BuildContext context,
    PhotoThemesState state,
    int crossAxisCount,
  ) {
    if (state.selectedThemeId == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            context.locale.photoThemesSelectThemeHint,
            style: MyTheme.of(context).hintTextStyle,
          ),
        ),
      );
    }

    if (state.players.isEmpty && !state.isLoading) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            context.locale.photoThemesNoPlayers,
            style: MyTheme.of(context).hintTextStyle,
          ),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: state.players.length,
      itemBuilder: (context, index) {
        final entry = state.players[index];
        return PhotoThemePlayerCell(
          entry: entry,
          onUploadPhoto: () => _pickAndUploadPhoto(
            context,
            state.selectedThemeId!,
            entry.playerId,
          ),
          onDeletePhoto: () => _onDeletePhoto(
            context,
            state.selectedThemeId!,
            entry.playerId,
          ),
          onRemovePlayer: () => _onRemovePlayer(context, entry.playerId),
        );
      },
    );
  }

  PhotoThemeModel? _findSelectedTheme(PhotoThemesState state) {
    if (state.selectedThemeId == null) return null;
    try {
      return state.themes.firstWhere((t) => t.id == state.selectedThemeId);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget? buildMobile(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            onPressed: context.backOrGoToDefault((c) => widget.tournamentId != null
                ? TournamentPage.createLocation(context: c, tournamentId: widget.tournamentId!)
                : ProfilePage.createLocation(c))),
        title: Text(context.locale.photoThemesTitle),
        actions: [
          if (widget.tournamentId != null)
            TournamentMenuAction(
              tournamentId: widget.tournamentId!,
              openDrawer: () => Scaffold.of(context).openEndDrawer(),
            ),
        ],
      ),
      body: BlocBuilder<PhotoThemesBloc, PhotoThemesState>(
        builder: (context, state) {
          final selectedTheme = _findSelectedTheme(state);

          return Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = (constraints.maxWidth / 110).floor().clamp(3, 6);
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            if (state.themes.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: CustomDropdown<PhotoThemeModel>(
                                  items: state.themes,
                                  initValue: selectedTheme,
                                  mapToString: (item) => item?.name ?? '',
                                  onChanged: (value) {
                                    if (value != null) {
                                      context.read<PhotoThemesBloc>().add(
                                            PhotoThemesEventSelectTheme(
                                              themeId: value.id,
                                            ),
                                          );
                                    }
                                  },
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomButton(
                                    text: context.locale.photoThemesCreateShort,
                                    onTap: () => _onCreateTheme(context),
                                    minimize: true,
                                  ),
                                  if (selectedTheme != null) ...[
                                    const SizedBox(height: 8),
                                    CustomButton(
                                      text: context.locale.photoThemesRenameShort,
                                      onTap: () => _onRenameTheme(
                                        context,
                                        selectedTheme,
                                      ),
                                      minimize: true,
                                    ),
                                    const SizedBox(height: 8),
                                    CustomButton(
                                      text: context.locale.photoThemesDeleteShort,
                                      isRed: true,
                                      onTap: () => _onDeleteTheme(
                                        context,
                                        selectedTheme.id,
                                      ),
                                      minimize: true,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            if (selectedTheme != null && _isFromTournament)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: _buildActiveThemeButton(
                                  context,
                                  selectedThemeId: state.selectedThemeId,
                                ),
                              ),
                            if (selectedTheme != null && _isFromTournament)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 4,
                                ),
                                child: CustomButton(
                                  text: context.locale.photoThemesSaveFromTournament,
                                  onTap: () => _onAddFromTournament(context),
                                  minimize: true,
                                ),
                              ),
                            const AddPlayerToThemeWidget(),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                      ..._buildPlayersSliverGrid(
                        context,
                        state,
                        crossAxisCount,
                      ),
                    ],
                  );
                },
              ),
              if (state.isLoading) const LoadingOverlayWidget(),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildPlayersSliverGrid(
    BuildContext context,
    PhotoThemesState state,
    int crossAxisCount,
  ) {
    if (state.selectedThemeId == null) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                context.locale.photoThemesSelectThemeHint,
                style: MyTheme.of(context).hintTextStyle,
              ),
            ),
          ),
        ),
      ];
    }

    if (state.players.isEmpty && !state.isLoading) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                context.locale.photoThemesNoPlayers,
                style: MyTheme.of(context).hintTextStyle,
              ),
            ),
          ),
        ),
      ];
    }

    return [
      SliverPadding(
        padding: const EdgeInsets.all(12),
        sliver: SliverGrid.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemCount: state.players.length,
          itemBuilder: (context, index) {
            final entry = state.players[index];
            return PhotoThemePlayerCell(
              entry: entry,
              onUploadPhoto: () => _pickAndUploadPhoto(
                context,
                state.selectedThemeId!,
                entry.playerId,
              ),
              onDeletePhoto: () => _onDeletePhoto(
                context,
                state.selectedThemeId!,
                entry.playerId,
              ),
              onRemovePlayer: () => _onRemovePlayer(context, entry.playerId),
            );
          },
        ),
      ),
    ];
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return BlocBuilder<PhotoThemesBloc, PhotoThemesState>(
      builder: (context, state) {
        final selectedTheme = _findSelectedTheme(state);

        return Stack(
          children: [
            Row(
              children: [
                // Left panel - themes list
                SizedBox(
                  width: 250,
                  child: Container(
                    color: MyTheme.of(context).background2,
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          context.locale.photoThemesTitle,
                          style: MyTheme.of(context).headerTextStyle,
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: _buildThemesList(context, state),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: CustomButton(
                            text: context.locale.photoThemesCreateButton,
                            onTap: () => _onCreateTheme(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Right panel - theme details
                Expanded(
                  child: Container(
                    color: MyTheme.of(context).background2,
                    child: Column(
                      children: [
                        if (selectedTheme != null) ...[
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    selectedTheme.name,
                                    style: MyTheme.of(context).headerTextStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit, size: 20),
                                  onPressed: () => _onRenameTheme(
                                    context,
                                    selectedTheme,
                                  ),
                                  tooltip: context.locale.photoThemesRenameShort,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    size: 20,
                                    color: MyTheme.of(context).redColor,
                                  ),
                                  onPressed: () => _onDeleteTheme(
                                    context,
                                    selectedTheme.id,
                                  ),
                                  tooltip: context.locale.photoThemesDeleteShort,
                                ),
                              ],
                            ),
                          ),
                          if (_isFromTournament)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: _buildActiveThemeButton(
                                context,
                                selectedThemeId: state.selectedThemeId,
                              ),
                            ),
                          if (_isFromTournament)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomButton(
                                  text: context.locale.photoThemesSaveFromTournament,
                                  onTap: () => _onAddFromTournament(context),
                                  minimize: true,
                                ),
                              ),
                            ),
                          const AddPlayerToThemeWidget(),
                          const SizedBox(height: 8),
                        ],
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final crossAxisCount = (constraints.maxWidth / 110).floor().clamp(3, 10);
                              return _buildPlayersGrid(
                                context,
                                state,
                                crossAxisCount,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (state.isLoading) const LoadingOverlayWidget(),
          ],
        );
      },
    );
  }

  Widget _buildThemesList(BuildContext context, PhotoThemesState state) {
    if (_isFromTournament) {
      return BlocSelector<TournamentPageBloc, TournamentPageState, int?>(
        selector: (tState) => tState.activePhotoThemeId,
        builder: (context, activePhotoThemeId) {
          return ListView.builder(
            itemCount: state.themes.length,
            itemBuilder: (context, index) {
              final theme = state.themes[index];
              return PhotoThemeCard(
                theme: theme,
                isSelected: theme.id == state.selectedThemeId,
                isActive: theme.id == activePhotoThemeId,
                onTap: () {
                  context.read<PhotoThemesBloc>().add(
                        PhotoThemesEventSelectTheme(
                          themeId: theme.id,
                        ),
                      );
                },
              );
            },
          );
        },
      );
    }
    return ListView.builder(
      itemCount: state.themes.length,
      itemBuilder: (context, index) {
        final theme = state.themes[index];
        return PhotoThemeCard(
          theme: theme,
          isSelected: theme.id == state.selectedThemeId,
          isActive: false,
          onTap: () {
            context.read<PhotoThemesBloc>().add(
                  PhotoThemesEventSelectTheme(
                    themeId: theme.id,
                  ),
                );
          },
        );
      },
    );
  }

  Widget _buildActiveThemeButton(
    BuildContext context, {
    required int? selectedThemeId,
  }) {
    final tournamentId = widget.tournamentId;
    if (tournamentId == null) return const SizedBox.shrink();

    return BlocSelector<TournamentPageBloc, TournamentPageState, int?>(
      selector: (state) => state.activePhotoThemeId,
      builder: (context, activePhotoThemeId) {
        final isActive = selectedThemeId == activePhotoThemeId && activePhotoThemeId != null;

        return Row(
          children: [
            if (isActive)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.check_circle,
                  color: MyTheme.of(context).positiveColor,
                  size: 18,
                ),
              ),
            Text(
              isActive ? context.locale.photoThemesApplied : context.locale.photoThemesNotApplied,
              style: MyTheme.of(context).defaultTextStyle.copyWith(
                    color: isActive ? MyTheme.of(context).positiveColor : null,
                    fontSize: 13,
                  ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                context.read<TournamentPageBloc>().add(
                      TournamentPageEvent.setActivePhotoTheme(
                        themeId: isActive ? null : selectedThemeId,
                      ),
                    );
              },
              child: Text(
                isActive ? context.locale.photoThemesRemove : context.locale.photoThemesApply,
              ),
            ),
          ],
        );
      },
    );
  }
}
