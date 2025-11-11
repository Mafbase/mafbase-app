import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'tournament_settings_model.freezed.dart';

@freezed
class TournamentSettingsModel with _$TournamentSettingsModel {
  const factory TournamentSettingsModel({
    required int defaultGames,
    required int swissGames,
    required int finalGames,
    List<int>? buckets,
    @Default(false) bool hideResult,
    RatingScheme? ratingScheme,
  }) = _TournamentSettingsModel;

  factory TournamentSettingsModel.fromProto(TournamentSettings proto) => TournamentSettingsModel(
        defaultGames: proto.defaultGamesCount,
        swissGames: proto.swissGamesCount,
        finalGames: proto.finalGamesCount,
        buckets: proto.buckets,
        hideResult: proto.hideResult,
        ratingScheme: proto.scheme,
      );
}

extension TournamentSettingsModelExt on TournamentSettingsModel {
  TournamentSettings toProto() => TournamentSettings(
        defaultGamesCount: defaultGames,
        swissGamesCount: swissGames,
        finalGamesCount: finalGames,
        buckets: buckets,
        hideResult: hideResult,
        scheme: ratingScheme,
      );
}
