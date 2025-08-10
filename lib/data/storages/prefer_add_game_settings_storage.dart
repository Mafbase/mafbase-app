import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _schemeKey = 'scheme-key';

abstract class PreferAddGameSettingsStorage {
  Future<RatingScheme?> getDefaultRatingScheme();

  Future<void> saveScheme(RatingScheme scheme);
}

class PreferAddGameSettingsStorageImpl implements PreferAddGameSettingsStorage {
  final _sharedPref = SharedPreferencesAsync();

  @override
  Future<RatingScheme?> getDefaultRatingScheme() =>
      _sharedPref.getInt(_schemeKey).then(
            (value) => value == null ? null : RatingScheme.valueOf(value),
          );

  @override
  Future<void> saveScheme(RatingScheme scheme) =>
      _sharedPref.setInt(_schemeKey, scheme.value);
}
