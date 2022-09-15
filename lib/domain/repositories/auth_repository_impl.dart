import 'package:seating_generator_web/data/requests/login_request.dart';
import 'package:seating_generator_web/data/requests/sign_up_request.dart';
import 'package:seating_generator_web/data/storages/token_storage.dart';
import 'package:seating_generator_web/domain/base_repository.dart';
import 'package:seating_generator_web/domain/models/login_model.dart';
import 'package:seating_generator_web/domain/models/sign_up_model.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  final TokenStorage _storage;

  AuthRepositoryImpl(super.client, this._storage);

  @override
  Future<LoginModel> login(String email, String password) {
    return LoginRequest(LoginEvent(email: email, password: password))
        .execute(client)
        .then(
      (value) async {
        await _storage.onTokensUpdated(value.token, value.recoveryToken);
        return const LoginModel.success();
      },
    ).onError(
      (error, stackTrace) => LoginModel.error(
        message: error?.toString(),
      ),
    );
  }

  @override
  Future<SignUpModel> signUp(String email, String password) {
    return SignUpRequest(SignUpEvent(email: email, password: password))
        .execute(client)
        .then(
      (value) async {
        switch (value.error) {
          case SignUpEventOut_Error.emailExist:
            return const SignUpModel.success();
          case SignUpEventOut_Error.noError:
            await _storage.onTokensUpdated(value.token, value.recoveryToken);
            return const SignUpModel.success();
          case SignUpEventOut_Error.weakPassword:
            return const SignUpModel.success();
        }
        return const SignUpModel.error(message: "Invalid response");
      },
    ).onError(
      (error, stackTrace) => SignUpModel.error(
        message: error?.toString(),
      ),
    );
  }
}
