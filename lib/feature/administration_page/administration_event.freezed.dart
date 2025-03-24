// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'administration_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AdministrationEvent {
  int get tournamentId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int tournamentId) pageOpened,
    required TResult Function(int tournamentId, String email) onAddOwnerTapped,
    required TResult Function(int tournamentId, int ownerId)
        onDeleteOwnerTapped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int tournamentId)? pageOpened,
    TResult? Function(int tournamentId, String email)? onAddOwnerTapped,
    TResult? Function(int tournamentId, int ownerId)? onDeleteOwnerTapped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int tournamentId)? pageOpened,
    TResult Function(int tournamentId, String email)? onAddOwnerTapped,
    TResult Function(int tournamentId, int ownerId)? onDeleteOwnerTapped,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AdministrationEventPageOpened value) pageOpened,
    required TResult Function(AdministrationEventAddOwner value)
        onAddOwnerTapped,
    required TResult Function(AdministrationEventDeleteOwner value)
        onDeleteOwnerTapped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdministrationEventPageOpened value)? pageOpened,
    TResult? Function(AdministrationEventAddOwner value)? onAddOwnerTapped,
    TResult? Function(AdministrationEventDeleteOwner value)?
        onDeleteOwnerTapped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdministrationEventPageOpened value)? pageOpened,
    TResult Function(AdministrationEventAddOwner value)? onAddOwnerTapped,
    TResult Function(AdministrationEventDeleteOwner value)? onDeleteOwnerTapped,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of AdministrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdministrationEventCopyWith<AdministrationEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdministrationEventCopyWith<$Res> {
  factory $AdministrationEventCopyWith(
          AdministrationEvent value, $Res Function(AdministrationEvent) then) =
      _$AdministrationEventCopyWithImpl<$Res, AdministrationEvent>;
  @useResult
  $Res call({int tournamentId});
}

/// @nodoc
class _$AdministrationEventCopyWithImpl<$Res, $Val extends AdministrationEvent>
    implements $AdministrationEventCopyWith<$Res> {
  _$AdministrationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdministrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tournamentId = null,
  }) {
    return _then(_value.copyWith(
      tournamentId: null == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdministrationEventPageOpenedImplCopyWith<$Res>
    implements $AdministrationEventCopyWith<$Res> {
  factory _$$AdministrationEventPageOpenedImplCopyWith(
          _$AdministrationEventPageOpenedImpl value,
          $Res Function(_$AdministrationEventPageOpenedImpl) then) =
      __$$AdministrationEventPageOpenedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int tournamentId});
}

/// @nodoc
class __$$AdministrationEventPageOpenedImplCopyWithImpl<$Res>
    extends _$AdministrationEventCopyWithImpl<$Res,
        _$AdministrationEventPageOpenedImpl>
    implements _$$AdministrationEventPageOpenedImplCopyWith<$Res> {
  __$$AdministrationEventPageOpenedImplCopyWithImpl(
      _$AdministrationEventPageOpenedImpl _value,
      $Res Function(_$AdministrationEventPageOpenedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdministrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tournamentId = null,
  }) {
    return _then(_$AdministrationEventPageOpenedImpl(
      tournamentId: null == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AdministrationEventPageOpenedImpl
    implements AdministrationEventPageOpened {
  const _$AdministrationEventPageOpenedImpl({required this.tournamentId});

  @override
  final int tournamentId;

  @override
  String toString() {
    return 'AdministrationEvent.pageOpened(tournamentId: $tournamentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdministrationEventPageOpenedImpl &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tournamentId);

  /// Create a copy of AdministrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdministrationEventPageOpenedImplCopyWith<
          _$AdministrationEventPageOpenedImpl>
      get copyWith => __$$AdministrationEventPageOpenedImplCopyWithImpl<
          _$AdministrationEventPageOpenedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int tournamentId) pageOpened,
    required TResult Function(int tournamentId, String email) onAddOwnerTapped,
    required TResult Function(int tournamentId, int ownerId)
        onDeleteOwnerTapped,
  }) {
    return pageOpened(tournamentId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int tournamentId)? pageOpened,
    TResult? Function(int tournamentId, String email)? onAddOwnerTapped,
    TResult? Function(int tournamentId, int ownerId)? onDeleteOwnerTapped,
  }) {
    return pageOpened?.call(tournamentId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int tournamentId)? pageOpened,
    TResult Function(int tournamentId, String email)? onAddOwnerTapped,
    TResult Function(int tournamentId, int ownerId)? onDeleteOwnerTapped,
    required TResult orElse(),
  }) {
    if (pageOpened != null) {
      return pageOpened(tournamentId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AdministrationEventPageOpened value) pageOpened,
    required TResult Function(AdministrationEventAddOwner value)
        onAddOwnerTapped,
    required TResult Function(AdministrationEventDeleteOwner value)
        onDeleteOwnerTapped,
  }) {
    return pageOpened(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdministrationEventPageOpened value)? pageOpened,
    TResult? Function(AdministrationEventAddOwner value)? onAddOwnerTapped,
    TResult? Function(AdministrationEventDeleteOwner value)?
        onDeleteOwnerTapped,
  }) {
    return pageOpened?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdministrationEventPageOpened value)? pageOpened,
    TResult Function(AdministrationEventAddOwner value)? onAddOwnerTapped,
    TResult Function(AdministrationEventDeleteOwner value)? onDeleteOwnerTapped,
    required TResult orElse(),
  }) {
    if (pageOpened != null) {
      return pageOpened(this);
    }
    return orElse();
  }
}

abstract class AdministrationEventPageOpened implements AdministrationEvent {
  const factory AdministrationEventPageOpened(
      {required final int tournamentId}) = _$AdministrationEventPageOpenedImpl;

  @override
  int get tournamentId;

  /// Create a copy of AdministrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdministrationEventPageOpenedImplCopyWith<
          _$AdministrationEventPageOpenedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AdministrationEventAddOwnerImplCopyWith<$Res>
    implements $AdministrationEventCopyWith<$Res> {
  factory _$$AdministrationEventAddOwnerImplCopyWith(
          _$AdministrationEventAddOwnerImpl value,
          $Res Function(_$AdministrationEventAddOwnerImpl) then) =
      __$$AdministrationEventAddOwnerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int tournamentId, String email});
}

/// @nodoc
class __$$AdministrationEventAddOwnerImplCopyWithImpl<$Res>
    extends _$AdministrationEventCopyWithImpl<$Res,
        _$AdministrationEventAddOwnerImpl>
    implements _$$AdministrationEventAddOwnerImplCopyWith<$Res> {
  __$$AdministrationEventAddOwnerImplCopyWithImpl(
      _$AdministrationEventAddOwnerImpl _value,
      $Res Function(_$AdministrationEventAddOwnerImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdministrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tournamentId = null,
    Object? email = null,
  }) {
    return _then(_$AdministrationEventAddOwnerImpl(
      tournamentId: null == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as int,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AdministrationEventAddOwnerImpl implements AdministrationEventAddOwner {
  const _$AdministrationEventAddOwnerImpl(
      {required this.tournamentId, required this.email});

  @override
  final int tournamentId;
  @override
  final String email;

  @override
  String toString() {
    return 'AdministrationEvent.onAddOwnerTapped(tournamentId: $tournamentId, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdministrationEventAddOwnerImpl &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId) &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tournamentId, email);

  /// Create a copy of AdministrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdministrationEventAddOwnerImplCopyWith<_$AdministrationEventAddOwnerImpl>
      get copyWith => __$$AdministrationEventAddOwnerImplCopyWithImpl<
          _$AdministrationEventAddOwnerImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int tournamentId) pageOpened,
    required TResult Function(int tournamentId, String email) onAddOwnerTapped,
    required TResult Function(int tournamentId, int ownerId)
        onDeleteOwnerTapped,
  }) {
    return onAddOwnerTapped(tournamentId, email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int tournamentId)? pageOpened,
    TResult? Function(int tournamentId, String email)? onAddOwnerTapped,
    TResult? Function(int tournamentId, int ownerId)? onDeleteOwnerTapped,
  }) {
    return onAddOwnerTapped?.call(tournamentId, email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int tournamentId)? pageOpened,
    TResult Function(int tournamentId, String email)? onAddOwnerTapped,
    TResult Function(int tournamentId, int ownerId)? onDeleteOwnerTapped,
    required TResult orElse(),
  }) {
    if (onAddOwnerTapped != null) {
      return onAddOwnerTapped(tournamentId, email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AdministrationEventPageOpened value) pageOpened,
    required TResult Function(AdministrationEventAddOwner value)
        onAddOwnerTapped,
    required TResult Function(AdministrationEventDeleteOwner value)
        onDeleteOwnerTapped,
  }) {
    return onAddOwnerTapped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdministrationEventPageOpened value)? pageOpened,
    TResult? Function(AdministrationEventAddOwner value)? onAddOwnerTapped,
    TResult? Function(AdministrationEventDeleteOwner value)?
        onDeleteOwnerTapped,
  }) {
    return onAddOwnerTapped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdministrationEventPageOpened value)? pageOpened,
    TResult Function(AdministrationEventAddOwner value)? onAddOwnerTapped,
    TResult Function(AdministrationEventDeleteOwner value)? onDeleteOwnerTapped,
    required TResult orElse(),
  }) {
    if (onAddOwnerTapped != null) {
      return onAddOwnerTapped(this);
    }
    return orElse();
  }
}

abstract class AdministrationEventAddOwner implements AdministrationEvent {
  const factory AdministrationEventAddOwner(
      {required final int tournamentId,
      required final String email}) = _$AdministrationEventAddOwnerImpl;

  @override
  int get tournamentId;
  String get email;

  /// Create a copy of AdministrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdministrationEventAddOwnerImplCopyWith<_$AdministrationEventAddOwnerImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AdministrationEventDeleteOwnerImplCopyWith<$Res>
    implements $AdministrationEventCopyWith<$Res> {
  factory _$$AdministrationEventDeleteOwnerImplCopyWith(
          _$AdministrationEventDeleteOwnerImpl value,
          $Res Function(_$AdministrationEventDeleteOwnerImpl) then) =
      __$$AdministrationEventDeleteOwnerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int tournamentId, int ownerId});
}

/// @nodoc
class __$$AdministrationEventDeleteOwnerImplCopyWithImpl<$Res>
    extends _$AdministrationEventCopyWithImpl<$Res,
        _$AdministrationEventDeleteOwnerImpl>
    implements _$$AdministrationEventDeleteOwnerImplCopyWith<$Res> {
  __$$AdministrationEventDeleteOwnerImplCopyWithImpl(
      _$AdministrationEventDeleteOwnerImpl _value,
      $Res Function(_$AdministrationEventDeleteOwnerImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdministrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tournamentId = null,
    Object? ownerId = null,
  }) {
    return _then(_$AdministrationEventDeleteOwnerImpl(
      tournamentId: null == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as int,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AdministrationEventDeleteOwnerImpl
    implements AdministrationEventDeleteOwner {
  const _$AdministrationEventDeleteOwnerImpl(
      {required this.tournamentId, required this.ownerId});

  @override
  final int tournamentId;
  @override
  final int ownerId;

  @override
  String toString() {
    return 'AdministrationEvent.onDeleteOwnerTapped(tournamentId: $tournamentId, ownerId: $ownerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdministrationEventDeleteOwnerImpl &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tournamentId, ownerId);

  /// Create a copy of AdministrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdministrationEventDeleteOwnerImplCopyWith<
          _$AdministrationEventDeleteOwnerImpl>
      get copyWith => __$$AdministrationEventDeleteOwnerImplCopyWithImpl<
          _$AdministrationEventDeleteOwnerImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int tournamentId) pageOpened,
    required TResult Function(int tournamentId, String email) onAddOwnerTapped,
    required TResult Function(int tournamentId, int ownerId)
        onDeleteOwnerTapped,
  }) {
    return onDeleteOwnerTapped(tournamentId, ownerId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int tournamentId)? pageOpened,
    TResult? Function(int tournamentId, String email)? onAddOwnerTapped,
    TResult? Function(int tournamentId, int ownerId)? onDeleteOwnerTapped,
  }) {
    return onDeleteOwnerTapped?.call(tournamentId, ownerId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int tournamentId)? pageOpened,
    TResult Function(int tournamentId, String email)? onAddOwnerTapped,
    TResult Function(int tournamentId, int ownerId)? onDeleteOwnerTapped,
    required TResult orElse(),
  }) {
    if (onDeleteOwnerTapped != null) {
      return onDeleteOwnerTapped(tournamentId, ownerId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AdministrationEventPageOpened value) pageOpened,
    required TResult Function(AdministrationEventAddOwner value)
        onAddOwnerTapped,
    required TResult Function(AdministrationEventDeleteOwner value)
        onDeleteOwnerTapped,
  }) {
    return onDeleteOwnerTapped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdministrationEventPageOpened value)? pageOpened,
    TResult? Function(AdministrationEventAddOwner value)? onAddOwnerTapped,
    TResult? Function(AdministrationEventDeleteOwner value)?
        onDeleteOwnerTapped,
  }) {
    return onDeleteOwnerTapped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdministrationEventPageOpened value)? pageOpened,
    TResult Function(AdministrationEventAddOwner value)? onAddOwnerTapped,
    TResult Function(AdministrationEventDeleteOwner value)? onDeleteOwnerTapped,
    required TResult orElse(),
  }) {
    if (onDeleteOwnerTapped != null) {
      return onDeleteOwnerTapped(this);
    }
    return orElse();
  }
}

abstract class AdministrationEventDeleteOwner implements AdministrationEvent {
  const factory AdministrationEventDeleteOwner(
      {required final int tournamentId,
      required final int ownerId}) = _$AdministrationEventDeleteOwnerImpl;

  @override
  int get tournamentId;
  int get ownerId;

  /// Create a copy of AdministrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdministrationEventDeleteOwnerImplCopyWith<
          _$AdministrationEventDeleteOwnerImpl>
      get copyWith => throw _privateConstructorUsedError;
}
