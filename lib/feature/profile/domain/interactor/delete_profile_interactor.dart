import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/interactors/logout_interactor.dart';
import 'package:seating_generator_web/feature/profile/domain/repository/profile_repository.dart';

class DeleteProfileInteractor extends BaseInteractor {
  final LogoutInteractor logoutInteractor;
  final ProfileRepository profileRepository;

  DeleteProfileInteractor(
    this.logoutInteractor,
    this.profileRepository,
  );

  Future<void> run() => wrap(
        () async {
          await profileRepository.deleteAccount();
          await logoutInteractor();
        },
      );

  @override
  String get interactorName => 'DeleteProfileInteractor';
}
