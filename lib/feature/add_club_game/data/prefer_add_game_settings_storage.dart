import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _schemeKey = 'scheme-key';
const _ciSchemeIdKey = 'ci-scheme-id-key';

abstract class PreferAddGameSettingsStorage {
  Future<RatingScheme?> getDefaultRatingScheme();

  Future<void> saveScheme(RatingScheme scheme);

  Future<int?> getDefaultCiSchemeId();

  Future<void> saveDefaultCiSchemeId(int ciId);
}

class PreferAddGameSettingsStorageImpl implements PreferAddGameSettingsStorage {
  final _sharedPref = SharedPreferencesAsync();

  @override
  Future<RatingScheme?> getDefaultRatingScheme() => _sharedPref.getInt(_schemeKey).then(
        (value) => value == null ? null : RatingScheme.valueOf(value),
      );

  @override
  Future<void> saveScheme(RatingScheme scheme) => _sharedPref.setInt(_schemeKey, scheme.value);

  @override
  Future<int?> getDefaultCiSchemeId() => _sharedPref.getInt(_ciSchemeIdKey);

  @override
  Future<void> saveDefaultCiSchemeId(int ciId) => _sharedPref.setInt(_ciSchemeIdKey, ciId);
}
