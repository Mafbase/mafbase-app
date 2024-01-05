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
  List<int>? get buckets => throw _privateConstructorUsedError;

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
  $Res call(
      {int defaultGames, int swissGames, int finalGames, List<int>? buckets});
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
    Object? buckets = freezed,
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
      buckets: freezed == buckets
          ? _value.buckets
          : buckets // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TournamentSettingsModelImplCopyWith<$Res>
    implements $TournamentSettingsModelCopyWith<$Res> {
  factory _$$TournamentSettingsModelImplCopyWith(
          _$TournamentSettingsModelImpl value,
          $Res Function(_$TournamentSettingsModelImpl) then) =
      __$$TournamentSettingsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int defaultGames, int swissGames, int finalGames, List<int>? buckets});
}

/// @nodoc
class __$$TournamentSettingsModelImplCopyWithImpl<$Res>
    extends _$TournamentSettingsModelCopyWithImpl<$Res,
        _$TournamentSettingsModelImpl>
    implements _$$TournamentSettingsModelImplCopyWith<$Res> {
  __$$TournamentSettingsModelImplCopyWithImpl(
      _$TournamentSettingsModelImpl _value,
      $Res Function(_$TournamentSettingsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultGames = null,
    Object? swissGames = null,
    Object? finalGames = null,
    Object? buckets = freezed,
  }) {
    return _then(_$TournamentSettingsModelImpl(
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
      buckets: freezed == buckets
          ? _value._buckets
          : buckets // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc

class _$TournamentSettingsModelImpl implements _TournamentSettingsModel {
  const _$TournamentSettingsModelImpl(
      {required this.defaultGames,
      required this.swissGames,
      required this.finalGames,
      final List<int>? buckets})
      : _buckets = buckets;

  @override
  final int defaultGames;
  @override
  final int swissGames;
  @override
  final int finalGames;
  final List<int>? _buckets;
  @override
  List<int>? get buckets {
    final value = _buckets;
    if (value == null) return null;
    if (_buckets is EqualUnmodifiableListView) return _buckets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'TournamentSettingsModel(defaultGames: $defaultGames, swissGames: $swissGames, finalGames: $finalGames, buckets: $buckets)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TournamentSettingsModelImpl &&
            (identical(other.defaultGames, defaultGames) ||
                other.defaultGames == defaultGames) &&
            (identical(other.swissGames, swissGames) ||
                other.swissGames == swissGames) &&
            (identical(other.finalGames, finalGames) ||
                other.finalGames == finalGames) &&
            const DeepCollectionEquality().equals(other._buckets, _buckets));
  }

  @override
  int get hashCode => Object.hash(runtimeType, defaultGames, swissGames,
      finalGames, const DeepCollectionEquality().hash(_buckets));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TournamentSettingsModelImplCopyWith<_$TournamentSettingsModelImpl>
      get copyWith => __$$TournamentSettingsModelImplCopyWithImpl<
          _$TournamentSettingsModelImpl>(this, _$identity);
}

abstract class _TournamentSettingsModel implements TournamentSettingsModel {
  const factory _TournamentSettingsModel(
      {required final int defaultGames,
      required final int swissGames,
      required final int finalGames,
      final List<int>? buckets}) = _$TournamentSettingsModelImpl;

  @override
  int get defaultGames;
  @override
  int get swissGames;
  @override
  int get finalGames;
  @override
  List<int>? get buckets;
  @override
  @JsonKey(ignore: true)
  _$$TournamentSettingsModelImplCopyWith<_$TournamentSettingsModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
