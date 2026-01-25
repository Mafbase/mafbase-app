import 'dart:math';

import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/ui/temp/temp_event.dart';
import 'package:seating_generator_web/ui/temp/temp_state.dart';

class TempBloc extends Bloc<TempEvent, TempState> {
  TempBloc() : super(const TempState(style: TempStyle.hide)) {
    on<TempEventGenerate>(_onGenerate);
  }

  _onGenerate(TempEventGenerate event, Emitter emit) {
    final a = Random().nextInt(250);
    if (state.style != TempStyle.hide) {
      emit(state.copyWith(style: TempStyle.hide));
    } else if (a == 0) {
      emit(state.copyWith(style: TempStyle.gold));
    } else if (a < 11) {
      emit(state.copyWith(style: TempStyle.classic));
    } else {
      emit(state.copyWith(style: TempStyle.empty));
    }
  }

}
