import 'package:bloc/src/bloc.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/ui/login/verification_body/verification_events.dart';
import 'package:seating_generator_web/ui/login/verification_body/verification_state.dart';

class VerificationBloc extends CustomBloc<VerificationEvents, VerificationState>{
  VerificationBloc() : super(const VerificationState(isLoading: false));

  Future _onSubmit(VerificationEventSubmit event, Emitter<VerificationState> emit) async {

  }
  @override
  void emitOnError(Emitter<VerificationState> emit) {
    emit(state.copyWith(isLoading: false));
  }

}