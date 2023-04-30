import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:seating_generator_web/data/storages/token_storage.dart';

class TokenStorageHiveImpl implements TokenStorage {
  static const _authTokenKey = 'auth_token';
  static const _recoveryTokenKey = 'recovery_token';
  static const _boxName = 'auth_tokens_box';

  late final Future<LazyBox<String>> _box = Hive.openLazyBox<String>(_boxName);

  @override
  FutureOr<String?> get authToken =>
      _box.then((value) => value.get(_authTokenKey));

  @override
  Future onTokensUpdated(String authToken, String recoveryToken) async {
    return Future.wait([
      _box.then((value) => value.put(_authTokenKey, authToken)),
      _box.then((value) => value.put(_recoveryTokenKey, recoveryToken)),
    ]);
  }

  @override
  FutureOr<String?> get recoveryToken =>
      _box.then((value) => value.get(_recoveryTokenKey));

  @override
  FutureOr clear() {
    return _box.then((value) => value.clear());
  }
}
