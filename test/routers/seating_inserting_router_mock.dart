import 'dart:async';

import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_router.dart';

class SeatingInsertingRouterMock implements SeatingInsertingRouter {
  final _errorDialogShowedController = StreamController<bool>.broadcast();
  final _successDialogShowedController = StreamController<bool>.broadcast();

  Stream<bool> get errorDialogShown => _errorDialogShowedController.stream;

  Stream<bool> get successDialogShown => _successDialogShowedController.stream;

  @override
  void showErrorDialog() {
    _errorDialogShowedController.add(true);
  }

  @override
  void showSuccessDialog() {
    _successDialogShowedController.add(true);
  }
}