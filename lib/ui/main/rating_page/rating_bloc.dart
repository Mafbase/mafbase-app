import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/download_rating_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_rating_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_tournament_rating_interactor.dart';
import 'package:seating_generator_web/domain/models/rating_model.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_event.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_router.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  final RepositoryFactory _repos;
  final RatingRouter _router;
  late final DownloadRatingInteractor _downloadRatingInteractor =
      DownloadRatingInteractor(_repos.clubRepository);
  late final GetRatingInteractor _getRatingRepository =
      GetRatingInteractor(_repos.clubRepository);
  late final GetTournamentRatingInteractor _getTournamentRatingInteractor =
      GetTournamentRatingInteractor(_repos.tournamentResultRepository);

  RatingBloc({
    required RepositoryFactory repos,
    required RatingRouter router,
  })  : _repos = repos,
        _router = router,
        super(const RatingState()) {
    on<RatingEventPageOpened>(_onPageOpened);
    on<RatingEventRangeChanged>(_onRangeChanged);
    on<RatingEventGameSelected>(_onGameSelected);
    on<RatingEventDownload>(_onDownloadRatingClicked);
    on<RatingEventDownloadStats>(_onStatsDownload);
  }

  _onStatsDownload(RatingEventDownloadStats event, Emitter emit) => _repos.clubRepository.downloadStats(
      clubId: event.clubId,
      range: event.range,
    );

  _onGameSelected(RatingEventGameSelected event, Emitter emit) {
    final clubId = event.clubId;
    if (clubId != null) {
      _router.openGame(clubId, event.gameId);
      return;
    }

    final tournamentId = event.tournamentId;
    if (tournamentId != null) {
      _router.openTournamentGame(
        tournamentId,
        event.gameId,
      );
    }
  }

  _onDownloadRatingClicked(
    RatingEventDownload event,
    Emitter emit,
  ) async {
    await _downloadRatingInteractor.run(
      clubId: event.clubId,
      range: event.range,
    );
  }

  _onRangeChanged(RatingEventRangeChanged event, Emitter emit) {
    _router.changeRange(
      event.range,
      event.clubId,
      event.tournamentId,
      event.style,
      event.sort,
      event.gameFilter,
      customSortColumnIndex: event.customSortColumnIndex,
    );
  }

  _onPageOpened(RatingEventPageOpened event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    final RatingModel rating;
    if (event.clubId != null) {
      rating = await _getRatingRepository.run(
        clubId: event.clubId!,
        range: event.range!,
      );
    } else if (event.tournamentId != null) {
      rating = await _getTournamentRatingInteractor(
        tournamentId: event.tournamentId!,
      );
    } else {
      throw ArgumentError();
    }
    rating;
    final hasCustomColumns = rating.rows.any(
      (row) => row.customColumns.isNotEmpty,
    );
    emit(
      state.copyWith(
        isLoading: false,
        rows: rating.rows,
        clubName: rating.clubName,
        games: rating.games,
        mafiaWins: rating.mafiaWins,
        citizenWins: rating.citizenWins,
        hasCustomColumns: hasCustomColumns,
      ),
    );
  }

}
