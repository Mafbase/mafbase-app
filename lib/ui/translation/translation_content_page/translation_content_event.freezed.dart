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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
}

/// @nodoc
abstract class _$$TranslationContentEventStateReceivedCopyWith<$Res> {
  factory _$$TranslationContentEventStateReceivedCopyWith(
          _$TranslationContentEventStateReceived value,
          $Res Function(_$TranslationContentEventStateReceived) then) =
      __$$TranslationContentEventStateReceivedCopyWithImpl<$Res>;
  @useResult
  $Res call({SeatingContent content});
}

/// @nodoc
class __$$TranslationContentEventStateReceivedCopyWithImpl<$Res>
    extends _$TranslationContentEventCopyWithImpl<$Res,
        _$TranslationContentEventStateReceived>
    implements _$$TranslationContentEventStateReceivedCopyWith<$Res> {
  __$$TranslationContentEventStateReceivedCopyWithImpl(
      _$TranslationContentEventStateReceived _value,
      $Res Function(_$TranslationContentEventStateReceived) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
  }) {
    return _then(_$TranslationContentEventStateReceived(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as SeatingContent,
    ));
  }
}

/// @nodoc

class _$TranslationContentEventStateReceived
    implements TranslationContentEventStateReceived {
  const _$TranslationContentEventStateReceived({required this.content});

  @override
  final SeatingContent content;

  @override
  String toString() {
    return 'TranslationContentEvent.stateReceived(content: $content)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TranslationContentEventStateReceived &&
            (identical(other.content, content) || other.content == content));
  }

  @override
  int get hashCode => Object.hash(runtimeType, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TranslationContentEventStateReceivedCopyWith<
          _$TranslationContentEventStateReceived>
      get copyWith => __$$TranslationContentEventStateReceivedCopyWithImpl<
          _$TranslationContentEventStateReceived>(this, _$identity);

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
      _$TranslationContentEventStateReceived;

  SeatingContent get content;
  @JsonKey(ignore: true)
  _$$TranslationContentEventStateReceivedCopyWith<
          _$TranslationContentEventStateReceived>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TranslationContentEventPageOpenedCopyWith<$Res> {
  factory _$$TranslationContentEventPageOpenedCopyWith(
          _$TranslationContentEventPageOpened value,
          $Res Function(_$TranslationContentEventPageOpened) then) =
      __$$TranslationContentEventPageOpenedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TranslationContentEventPageOpenedCopyWithImpl<$Res>
    extends _$TranslationContentEventCopyWithImpl<$Res,
        _$TranslationContentEventPageOpened>
    implements _$$TranslationContentEventPageOpenedCopyWith<$Res> {
  __$$TranslationContentEventPageOpenedCopyWithImpl(
      _$TranslationContentEventPageOpened _value,
      $Res Function(_$TranslationContentEventPageOpened) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TranslationContentEventPageOpened
    implements TranslationContentEventPageOpened {
  const _$TranslationContentEventPageOpened();

  @override
  String toString() {
    return 'TranslationContentEvent.pageOpened()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TranslationContentEventPageOpened);
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
      _$TranslationContentEventPageOpened;
}
