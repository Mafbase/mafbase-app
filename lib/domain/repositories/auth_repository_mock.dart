import 'package:seating_generator_web/domain/models/login_model.dart';
import 'package:seating_generator_web/domain/models/sign_up_model.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository.dart';

class AuthRepositoryMock implements AuthRepository {
  @override
  Future<LoginModel> login(String email, String password) {
    return Future.microtask(() {
      if (email == "strelas" && password == "qwerty") {
        return const LoginModel.success();
      } else {
        return const LoginModel.error();
      }
    });
  }

  @override
  Future<SignUpModel> signUp(String email, String password) async {
    return Future.microtask(() {
      if (email == "strelas") {
        return const SignUpModel(error: ErrorEnum.emailExist);
      } else if (password == "1234") {
        return const SignUpModel(error: ErrorEnum.weakPassword);
      } else {
        return const SignUpModel();
      }
    });
  }
}