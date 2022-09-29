// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'main_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MainEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MainPageTab tab) switchTab,
    required TResult Function() backButtonPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(MainPageTab tab)? switchTab,
    TResult Function()? backButtonPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MainPageTab tab)? switchTab,
    TResult Function()? backButtonPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MainEventSwitchTab value) switchTab,
    required TResult Function(MainEventBackButtonPressed value)
        backButtonPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(MainEventSwitchTab value)? switchTab,
    TResult Function(MainEventBackButtonPressed value)? backButtonPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainEventSwitchTab value)? switchTab,
    TResult Function(MainEventBackButtonPressed value)? backButtonPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainEventCopyWith<$Res> {
  factory $MainEventCopyWith(MainEvent value, $Res Function(MainEvent) then) =
      _$MainEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$MainEventCopyWithImpl<$Res> implements $MainEventCopyWith<$Res> {
  _$MainEventCopyWithImpl(this._value, this._then);

  final MainEvent _value;
  // ignore: unused_field
  final $Res Function(MainEvent) _then;
}

/// @nodoc
abstract class _$$MainEventSwitchTabCopyWith<$Res> {
  factory _$$MainEventSwitchTabCopyWith(_$MainEventSwitchTab value,
          $Res Function(_$MainEventSwitchTab) then) =
      __$$MainEventSwitchTabCopyWithImpl<$Res>;
  $Res call({MainPageTab tab});
}

/// @nodoc
class __$$MainEventSwitchTabCopyWithImpl<$Res>
    extends _$MainEventCopyWithImpl<$Res>
    implements _$$MainEventSwitchTabCopyWith<$Res> {
  __$$MainEventSwitchTabCopyWithImpl(
      _$MainEventSwitchTab _value, $Res Function(_$MainEventSwitchTab) _then)
      : super(_value, (v) => _then(v as _$MainEventSwitchTab));

  @override
  _$MainEventSwitchTab get _value => super._value as _$MainEventSwitchTab;

  @override
  $Res call({
    Object? tab = freezed,
  }) {
    return _then(_$MainEventSwitchTab(
      tab: tab == freezed
          ? _value.tab
          : tab // ignore: cast_nullable_to_non_nullable
              as MainPageTab,
    ));
  }
}

/// @nodoc

class _$MainEventSwitchTab implements MainEventSwitchTab {
  const _$MainEventSwitchTab({required this.tab});

  @override
  final MainPageTab tab;

  @override
  String toString() {
    return 'MainEvent.switchTab(tab: $tab)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainEventSwitchTab &&
            const DeepCollectionEquality().equals(other.tab, tab));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(tab));

  @JsonKey(ignore: true)
  @override
  _$$MainEventSwitchTabCopyWith<_$MainEventSwitchTab> get copyWith =>
      __$$MainEventSwitchTabCopyWithImpl<_$MainEventSwitchTab>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MainPageTab tab) switchTab,
    required TResult Function() backButtonPressed,
  }) {
    return switchTab(tab);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(MainPageTab tab)? switchTab,
    TResult Function()? backButtonPressed,
  }) {
    return switchTab?.call(tab);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MainPageTab tab)? switchTab,
    TResult Function()? backButtonPressed,
    required TResult orElse(),
  }) {
    if (switchTab != null) {
      return switchTab(tab);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MainEventSwitchTab value) switchTab,
    required TResult Function(MainEventBackButtonPressed value)
        backButtonPressed,
  }) {
    return switchTab(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(MainEventSwitchTab value)? switchTab,
    TResult Function(MainEventBackButtonPressed value)? backButtonPressed,
  }) {
    return switchTab?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainEventSwitchTab value)? switchTab,
    TResult Function(MainEventBackButtonPressed value)? backButtonPressed,
    required TResult orElse(),
  }) {
    if (switchTab != null) {
      return switchTab(this);
    }
    return orElse();
  }
}

abstract class MainEventSwitchTab implements MainEvent {
  const factory MainEventSwitchTab({required final MainPageTab tab}) =
      _$MainEventSwitchTab;

  MainPageTab get tab;
  @JsonKey(ignore: true)
  _$$MainEventSwitchTabCopyWith<_$MainEventSwitchTab> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MainEventBackButtonPressedCopyWith<$Res> {
  factory _$$MainEventBackButtonPressedCopyWith(
          _$MainEventBackButtonPressed value,
          $Res Function(_$MainEventBackButtonPressed) then) =
      __$$MainEventBackButtonPressedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MainEventBackButtonPressedCopyWithImpl<$Res>
    extends _$MainEventCopyWithImpl<$Res>
    implements _$$MainEventBackButtonPressedCopyWith<$Res> {
  __$$MainEventBackButtonPressedCopyWithImpl(
      _$MainEventBackButtonPressed _value,
      $Res Function(_$MainEventBackButtonPressed) _then)
      : super(_value, (v) => _then(v as _$MainEventBackButtonPressed));

  @override
  _$MainEventBackButtonPressed get _value =>
      super._value as _$MainEventBackButtonPressed;
}

/// @nodoc

class _$MainEventBackButtonPressed implements MainEventBackButtonPressed {
  const _$MainEventBackButtonPressed();

  @override
  String toString() {
    return 'MainEvent.backButtonPressed()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainEventBackButtonPressed);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MainPageTab tab) switchTab,
    required TResult Function() backButtonPressed,
  }) {
    return backButtonPressed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(MainPageTab tab)? switchTab,
    TResult Function()? backButtonPressed,
  }) {
    return backButtonPressed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MainPageTab tab)? switchTab,
    TResult Function()? backButtonPressed,
    required TResult orElse(),
  }) {
    if (backButtonPressed != null) {
      return backButtonPressed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MainEventSwitchTab value) switchTab,
    required TResult Function(MainEventBackButtonPressed value)
        backButtonPressed,
  }) {
    return backButtonPressed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(MainEventSwitchTab value)? switchTab,
    TResult Function(MainEventBackButtonPressed value)? backButtonPressed,
  }) {
    return backButtonPressed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainEventSwitchTab value)? switchTab,
    TResult Function(MainEventBackButtonPressed value)? backButtonPressed,
    required TResult orElse(),
  }) {
    if (backButtonPressed != null) {
      return backButtonPressed(this);
    }
    return orElse();
  }
}

abstract class MainEventBackButtonPressed implements MainEvent {
  const factory MainEventBackButtonPressed() = _$MainEventBackButtonPressed;
}
