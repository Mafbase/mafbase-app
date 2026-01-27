import 'package:seating_generator_web/data/requests/forgot_password_request.dart';
import 'package:seating_generator_web/data/requests/login_request.dart';
import 'package:seating_generator_web/data/requests/reset_password_request.dart';
import 'package:seating_generator_web/data/requests/sign_up_request.dart';
import 'package:seating_generator_web/data/requests/verification_request.dart';
import 'package:seating_generator_web/data/storages/token_storage.dart';
import 'package:seating_generator_web/data/base_repository.dart';
import 'package:seating_generator_web/domain/models/login_model.dart';
import 'package:seating_generator_web/domain/models/password_reset_model.dart';
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
        switch (value.error) {
          case LoginEventOut_Error.invalidCredentials:
            return const LoginModel.error();
          case LoginEventOut_Error.needVerification:
            return LoginModel.needVerification(id: value.id);
          case LoginEventOut_Error.noError:
            if (!value.hasId()) {
              throw Exception('User ID is missing in login response');
            }
            return LoginModel.success(userId: value.id);
        }
        if (!value.hasId()) {
          throw Exception('User ID is missing in login response');
        }
        return LoginModel.success(userId: value.id);
      },
    ).onError(
      (error, stackTrace) => LoginModel.error(
        message: error?.toString(),
      ),
    );
  }

  @override
  Future<SignUpModel> signUp(String email, String password) async {
    final value =
        await SignUpRequest(SignUpEvent(email: email, password: password))
            .execute(client);
    switch (value.error) {
      case SignUpEventOut_Error.emailExist:
        return const SignUpModel(error: ErrorEnum.emailExist);
      case SignUpEventOut_Error.noError:
        await _storage.onTokensUpdated(value.token, value.recoveryToken);
        return const SignUpModel();
      case SignUpEventOut_Error.weakPassword:
        return const SignUpModel(error: ErrorEnum.weakPassword);
      case SignUpEventOut_Error.needVerification:
        return SignUpModel(error: ErrorEnum.needVerification, id: value.id);
    }
    return throw Exception('Invalid response');
  }

  @override
  Future<bool> verificate(int id, String token) async {
    final value =
        await VerificationRequest(EmailVerificationEvent(id: id, token: token))
            .execute(client);
    switch (value.status) {
      case EmailVerificationEventOut_Status.incorrectToken:
        return false;
      case EmailVerificationEventOut_Status.success:
        return true;
    }
    return false;
  }

  @override
  Future<ForgotPasswordModel> forgotPassword(String email) async {
    try {
      final value = await ForgotPasswordRequest(
        ForgotPasswordEvent(email: email),
      ).execute(client);
      switch (value.error) {
        case ForgotPasswordEventOut_Error.noError:
          return const ForgotPasswordModel.success();
        case ForgotPasswordEventOut_Error.emailNotFound:
          return const ForgotPasswordModel.error();
      }
      return const ForgotPasswordModel.error();
    } catch (e) {
      return const ForgotPasswordModel.error();
    }
  }

  @override
  Future<ResetPasswordModel> resetPassword(
    String token,
    String email,
    String newPassword,
  ) async {
    try {
      final value = await ResetPasswordRequest(
        ResetPasswordEvent(
          token: token,
          email: email,
          newPassword: newPassword,
        ),
      ).execute(client);
      switch (value.error) {
        case ResetPasswordEventOut_Error.noError:
          return const ResetPasswordModel.success();
        case ResetPasswordEventOut_Error.invalidToken:
          return const ResetPasswordModel.error(
            ResetPasswordError.invalidToken,
          );
        case ResetPasswordEventOut_Error.weakPassword:
          return const ResetPasswordModel.error(
            ResetPasswordError.weakPassword,
          );
      }
      return const ResetPasswordModel.error(
        ResetPasswordError.invalidToken,
      );
    } catch (e) {
      return const ResetPasswordModel.error(
        ResetPasswordError.invalidToken,
      );
    }
  }
}
