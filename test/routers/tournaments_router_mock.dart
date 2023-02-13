import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_router.dart';
import 'package:seating_generator_web/ui/main/widgets/create_tournament_dialog.dart';

class TournamentsRouterMock implements TournamentsRouter {
  @override
  Future<CreateTournamentData?> openCreateTournamentDialog() async {
    return null;
  }

  @override
  void openTournament(int id) {}
}
