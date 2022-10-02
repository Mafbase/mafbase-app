import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/domain/repositories/tournaments_repository_mock.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_bloc.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_events.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_state.dart';

void main() {
  registerGetItTest();
  group('tournaments bloc', () {
    test('test init state', () {
      final bloc = getIt<TournamentsBloc>();

      expect(
        bloc.state,
        const TournamentsState(tournaments: [], isLoading: true),
      );
    });

    test('test loaded state', () async {
      final bloc = getIt<TournamentsBloc>();
      bloc.add(const TournamentsEvent.opened());

      final state = await bloc.stream
          .firstWhere((element) => !element.isLoading)
          .timeout(const Duration(seconds: 1));

      expect(
        state,
        TournamentsState(
          tournaments: TournamentsRepositoryMock.fakeTournaments,
          isLoading: false,
        ),
      );
    });
  });
}
