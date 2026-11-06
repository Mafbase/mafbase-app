import 'package:shared_preferences/shared_preferences.dart';

/// Помнит, что организатор закрыл баннер чеклиста на странице турнира.
abstract interface class ChecklistBannerStorage {
  Future<bool> isHidden(int tournamentId);

  Future<void> hide(int tournamentId);
}

class ChecklistBannerStorageImpl implements ChecklistBannerStorage {
  final _sharedPref = SharedPreferencesAsync();

  static String _key(int tournamentId) => 'checklist-banner-hidden-$tournamentId';

  @override
  Future<bool> isHidden(int tournamentId) => _sharedPref.getBool(_key(tournamentId)).then((value) => value ?? false);

  @override
  Future<void> hide(int tournamentId) => _sharedPref.setBool(_key(tournamentId), true);
}
