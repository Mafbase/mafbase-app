import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

abstract class SeatingInsertingRouter {
  void showSuccessDialog();

  void showErrorDialog();
}

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

class SeatingInsertingRouterImpl implements SeatingInsertingRouter {
  final BuildContext _context;

  SeatingInsertingRouterImpl(this._context);

  @override
  void showErrorDialog() {
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(_context)!.insertSeatingError),
      ),
    );
  }

  @override
  void showSuccessDialog() {
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(_context)!.insertSeatingSuccess),
      ),
    );
  }
}
