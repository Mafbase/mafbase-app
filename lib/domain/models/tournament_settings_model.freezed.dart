// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tournament_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TournamentSettingsModel {
  int get defaultGames => throw _privateConstructorUsedError;
  int get swissGames => throw _privateConstructorUsedError;
  int get finalGames => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TournamentSettingsModelCopyWith<TournamentSettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentSettingsModelCopyWith<$Res> {
  factory $TournamentSettingsModelCopyWith(TournamentSettingsModel value,
          $Res Function(TournamentSettingsModel) then) =
      _$TournamentSettingsModelCopyWithImpl<$Res, TournamentSettingsModel>;
  @useResult
  $Res call({int defaultGames, int swissGames, int finalGames});
}

/// @nodoc
class _$TournamentSettingsModelCopyWithImpl<$Res,
        $Val extends TournamentSettingsModel>
    implements $TournamentSettingsModelCopyWith<$Res> {
  _$TournamentSettingsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultGames = null,
    Object? swissGames = null,
    Object? finalGames = null,
  }) {
    return _then(_value.copyWith(
      defaultGames: null == defaultGames
          ? _value.defaultGames
          : defaultGames // ignore: cast_nullable_to_non_nullable
              as int,
      swissGames: null == swissGames
          ? _value.swissGames
          : swissGames // ignore: cast_nullable_to_non_nullable
              as int,
      finalGames: null == finalGames
          ? _value.finalGames
          : finalGames // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TournamentSettingsModelCopyWith<$Res>
    implements $TournamentSettingsModelCopyWith<$Res> {
  factory _$$_TournamentSettingsModelCopyWith(_$_TournamentSettingsModel value,
          $Res Function(_$_TournamentSettingsModel) then) =
      __$$_TournamentSettingsModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int defaultGames, int swissGames, int finalGames});
}

/// @nodoc
class __$$_TournamentSettingsModelCopyWithImpl<$Res>
    extends _$TournamentSettingsModelCopyWithImpl<$Res,
        _$_TournamentSettingsModel>
    implements _$$_TournamentSettingsModelCopyWith<$Res> {
  __$$_TournamentSettingsModelCopyWithImpl(_$_TournamentSettingsModel _value,
      $Res Function(_$_TournamentSettingsModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultGames = null,
    Object? swissGames = null,
    Object? finalGames = null,
  }) {
    return _then(_$_TournamentSettingsModel(
      defaultGames: null == defaultGames
          ? _value.defaultGames
          : defaultGames // ignore: cast_nullable_to_non_nullable
              as int,
      swissGames: null == swissGames
          ? _value.swissGames
          : swissGames // ignore: cast_nullable_to_non_nullable
              as int,
      finalGames: null == finalGames
          ? _value.finalGames
          : finalGames // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_TournamentSettingsModel implements _TournamentSettingsModel {
  const _$_TournamentSettingsModel(
      {required this.defaultGames,
      required this.swissGames,
      required this.finalGames});

  @override
  final int defaultGames;
  @override
  final int swissGames;
  @override
  final int finalGames;

  @override
  String toString() {
    return 'TournamentSettingsModel(defaultGames: $defaultGames, swissGames: $swissGames, finalGames: $finalGames)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TournamentSettingsModel &&
            (identical(other.defaultGames, defaultGames) ||
                other.defaultGames == defaultGames) &&
            (identical(other.swissGames, swissGames) ||
                other.swissGames == swissGames) &&
            (identical(other.finalGames, finalGames) ||
                other.finalGames == finalGames));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, defaultGames, swissGames, finalGames);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TournamentSettingsModelCopyWith<_$_TournamentSettingsModel>
      get copyWith =>
          __$$_TournamentSettingsModelCopyWithImpl<_$_TournamentSettingsModel>(
              this, _$identity);
}

abstract class _TournamentSettingsModel implements TournamentSettingsModel {
  const factory _TournamentSettingsModel(
      {required final int defaultGames,
      required final int swissGames,
      required final int finalGames}) = _$_TournamentSettingsModel;

  @override
  int get defaultGames;
  @override
  int get swissGames;
  @override
  int get finalGames;
  @override
  @JsonKey(ignore: true)
  _$$_TournamentSettingsModelCopyWith<_$_TournamentSettingsModel>
      get copyWith => throw _privateConstructorUsedError;
}
