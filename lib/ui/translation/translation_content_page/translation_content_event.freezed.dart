// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'translation_content_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TranslationContentEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SeatingContent content) stateReceived,
    required TResult Function() pageOpened,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SeatingContent content)? stateReceived,
    TResult? Function()? pageOpened,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SeatingContent content)? stateReceived,
    TResult Function()? pageOpened,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TranslationContentEventStateReceived value)
        stateReceived,
    required TResult Function(TranslationContentEventPageOpened value)
        pageOpened,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TranslationContentEventStateReceived value)?
        stateReceived,
    TResult? Function(TranslationContentEventPageOpened value)? pageOpened,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TranslationContentEventStateReceived value)? stateReceived,
    TResult Function(TranslationContentEventPageOpened value)? pageOpened,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TranslationContentEventCopyWith<$Res> {
  factory $TranslationContentEventCopyWith(TranslationContentEvent value,
          $Res Function(TranslationContentEvent) then) =
      _$TranslationContentEventCopyWithImpl<$Res, TranslationContentEvent>;
}

/// @nodoc
class _$TranslationContentEventCopyWithImpl<$Res,
        $Val extends TranslationContentEvent>
    implements $TranslationContentEventCopyWith<$Res> {
  _$TranslationContentEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TranslationContentEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TranslationContentEventStateReceivedImplCopyWith<$Res> {
  factory _$$TranslationContentEventStateReceivedImplCopyWith(
          _$TranslationContentEventStateReceivedImpl value,
          $Res Function(_$TranslationContentEventStateReceivedImpl) then) =
      __$$TranslationContentEventStateReceivedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SeatingContent content});
}

/// @nodoc
class __$$TranslationContentEventStateReceivedImplCopyWithImpl<$Res>
    extends _$TranslationContentEventCopyWithImpl<$Res,
        _$TranslationContentEventStateReceivedImpl>
    implements _$$TranslationContentEventStateReceivedImplCopyWith<$Res> {
  __$$TranslationContentEventStateReceivedImplCopyWithImpl(
      _$TranslationContentEventStateReceivedImpl _value,
      $Res Function(_$TranslationContentEventStateReceivedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TranslationContentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
  }) {
    return _then(_$TranslationContentEventStateReceivedImpl(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as SeatingContent,
    ));
  }
}

/// @nodoc

class _$TranslationContentEventStateReceivedImpl
    implements TranslationContentEventStateReceived {
  const _$TranslationContentEventStateReceivedImpl({required this.content});

  @override
  final SeatingContent content;

  @override
  String toString() {
    return 'TranslationContentEvent.stateReceived(content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TranslationContentEventStateReceivedImpl &&
            (identical(other.content, content) || other.content == content));
  }

  @override
  int get hashCode => Object.hash(runtimeType, content);

  /// Create a copy of TranslationContentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TranslationContentEventStateReceivedImplCopyWith<
          _$TranslationContentEventStateReceivedImpl>
      get copyWith => __$$TranslationContentEventStateReceivedImplCopyWithImpl<
          _$TranslationContentEventStateReceivedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SeatingContent content) stateReceived,
    required TResult Function() pageOpened,
  }) {
    return stateReceived(content);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SeatingContent content)? stateReceived,
    TResult? Function()? pageOpened,
  }) {
    return stateReceived?.call(content);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SeatingContent content)? stateReceived,
    TResult Function()? pageOpened,
    required TResult orElse(),
  }) {
    if (stateReceived != null) {
      return stateReceived(content);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TranslationContentEventStateReceived value)
        stateReceived,
    required TResult Function(TranslationContentEventPageOpened value)
        pageOpened,
  }) {
    return stateReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TranslationContentEventStateReceived value)?
        stateReceived,
    TResult? Function(TranslationContentEventPageOpened value)? pageOpened,
  }) {
    return stateReceived?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TranslationContentEventStateReceived value)? stateReceived,
    TResult Function(TranslationContentEventPageOpened value)? pageOpened,
    required TResult orElse(),
  }) {
    if (stateReceived != null) {
      return stateReceived(this);
    }
    return orElse();
  }
}

abstract class TranslationContentEventStateReceived
    implements TranslationContentEvent {
  const factory TranslationContentEventStateReceived(
          {required final SeatingContent content}) =
      _$TranslationContentEventStateReceivedImpl;

  SeatingContent get content;

  /// Create a copy of TranslationContentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TranslationContentEventStateReceivedImplCopyWith<
          _$TranslationContentEventStateReceivedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TranslationContentEventPageOpenedImplCopyWith<$Res> {
  factory _$$TranslationContentEventPageOpenedImplCopyWith(
          _$TranslationContentEventPageOpenedImpl value,
          $Res Function(_$TranslationContentEventPageOpenedImpl) then) =
      __$$TranslationContentEventPageOpenedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TranslationContentEventPageOpenedImplCopyWithImpl<$Res>
    extends _$TranslationContentEventCopyWithImpl<$Res,
        _$TranslationContentEventPageOpenedImpl>
    implements _$$TranslationContentEventPageOpenedImplCopyWith<$Res> {
  __$$TranslationContentEventPageOpenedImplCopyWithImpl(
      _$TranslationContentEventPageOpenedImpl _value,
      $Res Function(_$TranslationContentEventPageOpenedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TranslationContentEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TranslationContentEventPageOpenedImpl
    implements TranslationContentEventPageOpened {
  const _$TranslationContentEventPageOpenedImpl();

  @override
  String toString() {
    return 'TranslationContentEvent.pageOpened()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TranslationContentEventPageOpenedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SeatingContent content) stateReceived,
    required TResult Function() pageOpened,
  }) {
    return pageOpened();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SeatingContent content)? stateReceived,
    TResult? Function()? pageOpened,
  }) {
    return pageOpened?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SeatingContent content)? stateReceived,
    TResult Function()? pageOpened,
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
    required TResult Function(TranslationContentEventStateReceived value)
        stateReceived,
    required TResult Function(TranslationContentEventPageOpened value)
        pageOpened,
  }) {
    return pageOpened(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TranslationContentEventStateReceived value)?
        stateReceived,
    TResult? Function(TranslationContentEventPageOpened value)? pageOpened,
  }) {
    return pageOpened?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TranslationContentEventStateReceived value)? stateReceived,
    TResult Function(TranslationContentEventPageOpened value)? pageOpened,
    required TResult orElse(),
  }) {
    if (pageOpened != null) {
      return pageOpened(this);
    }
    return orElse();
  }
}

abstract class TranslationContentEventPageOpened
    implements TranslationContentEvent {
  const factory TranslationContentEventPageOpened() =
      _$TranslationContentEventPageOpenedImpl;
}
