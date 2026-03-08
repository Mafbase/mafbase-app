import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/feature/photo_themes/ui/photo_themes_bloc.dart';
import 'package:seating_generator_web/feature/photo_themes/ui/photo_themes_event.dart';
import 'package:seating_generator_web/feature/photo_themes/ui/photo_themes_state.dart';

class PhotoThemesBlocInjector extends StatelessWidget {
  final int? tournamentId;
  final Widget child;

  const PhotoThemesBlocInjector({
    super.key,
    this.tournamentId,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhotoThemesBloc>(
      create: (context) => PhotoThemesBloc(
        const PhotoThemesState(),
        RepositoryFactory.of(context).photoThemeRepository,
      )..add(PhotoThemesEventInit(tournamentId: tournamentId)),
      child: child,
    );
  }
}
