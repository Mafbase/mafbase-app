import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/ui/login/login_events.dart';
import 'package:seating_generator_web/ui/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.login(hasError: false)) {
  }
}
