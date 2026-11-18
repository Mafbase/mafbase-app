import 'package:flutter/material.dart';

abstract class ProfileDialogRouter {
  void close();
}

class ProfileDialogRouterImpl implements ProfileDialogRouter {
  final BuildContext context;

  ProfileDialogRouterImpl(this.context);

  @override
  void close() {
    Navigator.pop(context, true);
  }
}
