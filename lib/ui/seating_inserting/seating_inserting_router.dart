import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

abstract class SeatingInsertingRouter {
  void showSuccessDialog();

  void showErrorDialog();
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
