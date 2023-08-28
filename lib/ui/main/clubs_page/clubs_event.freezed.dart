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
    required TResult Function() pageOpened,
    required TResult Function(ClubModel clubModel) clubSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? pageOpened,
    TResult? Function(ClubModel clubModel)? clubSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? pageOpened,
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
abstract class _$$ClubsEventPageOpenedCopyWith<$Res> {
  factory _$$ClubsEventPageOpenedCopyWith(_$ClubsEventPageOpened value,
          $Res Function(_$ClubsEventPageOpened) then) =
      __$$ClubsEventPageOpenedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClubsEventPageOpenedCopyWithImpl<$Res>
    extends _$ClubsEventCopyWithImpl<$Res, _$ClubsEventPageOpened>
    implements _$$ClubsEventPageOpenedCopyWith<$Res> {
  __$$ClubsEventPageOpenedCopyWithImpl(_$ClubsEventPageOpened _value,
      $Res Function(_$ClubsEventPageOpened) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ClubsEventPageOpened implements ClubsEventPageOpened {
  const _$ClubsEventPageOpened();

  @override
  String toString() {
    return 'ClubsEvent.pageOpened()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClubsEventPageOpened);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() pageOpened,
    required TResult Function(ClubModel clubModel) clubSelected,
  }) {
    return pageOpened();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? pageOpened,
    TResult? Function(ClubModel clubModel)? clubSelected,
  }) {
    return pageOpened?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? pageOpened,
    TResult Function(ClubModel clubModel)? clubSelected,
    required TResult orElse(),
  }) {
    if (pageOpened != null) {
      return pageOpened();
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
  const factory ClubsEventPageOpened() = _$ClubsEventPageOpened;
}

/// @nodoc
abstract class _$$ClubsEventClubSelectedCopyWith<$Res> {
  factory _$$ClubsEventClubSelectedCopyWith(_$ClubsEventClubSelected value,
          $Res Function(_$ClubsEventClubSelected) then) =
      __$$ClubsEventClubSelectedCopyWithImpl<$Res>;
  @useResult
  $Res call({ClubModel clubModel});

  $ClubModelCopyWith<$Res> get clubModel;
}

/// @nodoc
class __$$ClubsEventClubSelectedCopyWithImpl<$Res>
    extends _$ClubsEventCopyWithImpl<$Res, _$ClubsEventClubSelected>
    implements _$$ClubsEventClubSelectedCopyWith<$Res> {
  __$$ClubsEventClubSelectedCopyWithImpl(_$ClubsEventClubSelected _value,
      $Res Function(_$ClubsEventClubSelected) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clubModel = null,
  }) {
    return _then(_$ClubsEventClubSelected(
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

class _$ClubsEventClubSelected implements ClubsEventClubSelected {
  const _$ClubsEventClubSelected({required this.clubModel});

  @override
  final ClubModel clubModel;

  @override
  String toString() {
    return 'ClubsEvent.clubSelected(clubModel: $clubModel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubsEventClubSelected &&
            (identical(other.clubModel, clubModel) ||
                other.clubModel == clubModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clubModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubsEventClubSelectedCopyWith<_$ClubsEventClubSelected> get copyWith =>
      __$$ClubsEventClubSelectedCopyWithImpl<_$ClubsEventClubSelected>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() pageOpened,
    required TResult Function(ClubModel clubModel) clubSelected,
  }) {
    return clubSelected(clubModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? pageOpened,
    TResult? Function(ClubModel clubModel)? clubSelected,
  }) {
    return clubSelected?.call(clubModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? pageOpened,
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
      _$ClubsEventClubSelected;

  ClubModel get clubModel;
  @JsonKey(ignore: true)
  _$$ClubsEventClubSelectedCopyWith<_$ClubsEventClubSelected> get copyWith =>
      throw _privateConstructorUsedError;
}
