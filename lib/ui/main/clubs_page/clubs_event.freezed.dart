// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clubs_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ClubsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Completer<dynamic>? completer) pageOpened,
    required TResult Function(ClubModel clubModel) clubSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Completer<dynamic>? completer)? pageOpened,
    TResult? Function(ClubModel clubModel)? clubSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Completer<dynamic>? completer)? pageOpened,
    TResult Function(ClubModel clubModel)? clubSelected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClubsEventPageOpened value) pageOpened,
    required TResult Function(ClubsEventClubSelected value) clubSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClubsEventPageOpened value)? pageOpened,
    TResult? Function(ClubsEventClubSelected value)? clubSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClubsEventPageOpened value)? pageOpened,
    TResult Function(ClubsEventClubSelected value)? clubSelected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubsEventCopyWith<$Res> {
  factory $ClubsEventCopyWith(
          ClubsEvent value, $Res Function(ClubsEvent) then) =
      _$ClubsEventCopyWithImpl<$Res, ClubsEvent>;
}

/// @nodoc
class _$ClubsEventCopyWithImpl<$Res, $Val extends ClubsEvent>
    implements $ClubsEventCopyWith<$Res> {
  _$ClubsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ClubsEventPageOpenedImplCopyWith<$Res> {
  factory _$$ClubsEventPageOpenedImplCopyWith(_$ClubsEventPageOpenedImpl value,
          $Res Function(_$ClubsEventPageOpenedImpl) then) =
      __$$ClubsEventPageOpenedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Completer<dynamic>? completer});
}

/// @nodoc
class __$$ClubsEventPageOpenedImplCopyWithImpl<$Res>
    extends _$ClubsEventCopyWithImpl<$Res, _$ClubsEventPageOpenedImpl>
    implements _$$ClubsEventPageOpenedImplCopyWith<$Res> {
  __$$ClubsEventPageOpenedImplCopyWithImpl(_$ClubsEventPageOpenedImpl _value,
      $Res Function(_$ClubsEventPageOpenedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? completer = freezed,
  }) {
    return _then(_$ClubsEventPageOpenedImpl(
      completer: freezed == completer
          ? _value.completer
          : completer // ignore: cast_nullable_to_non_nullable
              as Completer<dynamic>?,
    ));
  }
}

/// @nodoc

class _$ClubsEventPageOpenedImpl implements ClubsEventPageOpened {
  const _$ClubsEventPageOpenedImpl({this.completer});

  @override
  final Completer<dynamic>? completer;

  @override
  String toString() {
    return 'ClubsEvent.pageOpened(completer: $completer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubsEventPageOpenedImpl &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, completer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubsEventPageOpenedImplCopyWith<_$ClubsEventPageOpenedImpl>
      get copyWith =>
          __$$ClubsEventPageOpenedImplCopyWithImpl<_$ClubsEventPageOpenedImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Completer<dynamic>? completer) pageOpened,
    required TResult Function(ClubModel clubModel) clubSelected,
  }) {
    return pageOpened(completer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Completer<dynamic>? completer)? pageOpened,
    TResult? Function(ClubModel clubModel)? clubSelected,
  }) {
    return pageOpened?.call(completer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Completer<dynamic>? completer)? pageOpened,
    TResult Function(ClubModel clubModel)? clubSelected,
    required TResult orElse(),
  }) {
    if (pageOpened != null) {
      return pageOpened(completer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClubsEventPageOpened value) pageOpened,
    required TResult Function(ClubsEventClubSelected value) clubSelected,
  }) {
    return pageOpened(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClubsEventPageOpened value)? pageOpened,
    TResult? Function(ClubsEventClubSelected value)? clubSelected,
  }) {
    return pageOpened?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClubsEventPageOpened value)? pageOpened,
    TResult Function(ClubsEventClubSelected value)? clubSelected,
    required TResult orElse(),
  }) {
    if (pageOpened != null) {
      return pageOpened(this);
    }
    return orElse();
  }
}

abstract class ClubsEventPageOpened implements ClubsEvent {
  const factory ClubsEventPageOpened({final Completer<dynamic>? completer}) =
      _$ClubsEventPageOpenedImpl;

  Completer<dynamic>? get completer;
  @JsonKey(ignore: true)
  _$$ClubsEventPageOpenedImplCopyWith<_$ClubsEventPageOpenedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClubsEventClubSelectedImplCopyWith<$Res> {
  factory _$$ClubsEventClubSelectedImplCopyWith(
          _$ClubsEventClubSelectedImpl value,
          $Res Function(_$ClubsEventClubSelectedImpl) then) =
      __$$ClubsEventClubSelectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ClubModel clubModel});

  $ClubModelCopyWith<$Res> get clubModel;
}

/// @nodoc
class __$$ClubsEventClubSelectedImplCopyWithImpl<$Res>
    extends _$ClubsEventCopyWithImpl<$Res, _$ClubsEventClubSelectedImpl>
    implements _$$ClubsEventClubSelectedImplCopyWith<$Res> {
  __$$ClubsEventClubSelectedImplCopyWithImpl(
      _$ClubsEventClubSelectedImpl _value,
      $Res Function(_$ClubsEventClubSelectedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clubModel = null,
  }) {
    return _then(_$ClubsEventClubSelectedImpl(
      clubModel: null == clubModel
          ? _value.clubModel
          : clubModel // ignore: cast_nullable_to_non_nullable
              as ClubModel,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ClubModelCopyWith<$Res> get clubModel {
    return $ClubModelCopyWith<$Res>(_value.clubModel, (value) {
      return _then(_value.copyWith(clubModel: value));
    });
  }
}

/// @nodoc

class _$ClubsEventClubSelectedImpl implements ClubsEventClubSelected {
  const _$ClubsEventClubSelectedImpl({required this.clubModel});

  @override
  final ClubModel clubModel;

  @override
  String toString() {
    return 'ClubsEvent.clubSelected(clubModel: $clubModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubsEventClubSelectedImpl &&
            (identical(other.clubModel, clubModel) ||
                other.clubModel == clubModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clubModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubsEventClubSelectedImplCopyWith<_$ClubsEventClubSelectedImpl>
      get copyWith => __$$ClubsEventClubSelectedImplCopyWithImpl<
          _$ClubsEventClubSelectedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Completer<dynamic>? completer) pageOpened,
    required TResult Function(ClubModel clubModel) clubSelected,
  }) {
    return clubSelected(clubModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Completer<dynamic>? completer)? pageOpened,
    TResult? Function(ClubModel clubModel)? clubSelected,
  }) {
    return clubSelected?.call(clubModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Completer<dynamic>? completer)? pageOpened,
    TResult Function(ClubModel clubModel)? clubSelected,
    required TResult orElse(),
  }) {
    if (clubSelected != null) {
      return clubSelected(clubModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClubsEventPageOpened value) pageOpened,
    required TResult Function(ClubsEventClubSelected value) clubSelected,
  }) {
    return clubSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClubsEventPageOpened value)? pageOpened,
    TResult? Function(ClubsEventClubSelected value)? clubSelected,
  }) {
    return clubSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClubsEventPageOpened value)? pageOpened,
    TResult Function(ClubsEventClubSelected value)? clubSelected,
    required TResult orElse(),
  }) {
    if (clubSelected != null) {
      return clubSelected(this);
    }
    return orElse();
  }
}

abstract class ClubsEventClubSelected implements ClubsEvent {
  const factory ClubsEventClubSelected({required final ClubModel clubModel}) =
      _$ClubsEventClubSelectedImpl;

  ClubModel get clubModel;
  @JsonKey(ignore: true)
  _$$ClubsEventClubSelectedImplCopyWith<_$ClubsEventClubSelectedImpl>
      get copyWith => throw _privateConstructorUsedError;
}
