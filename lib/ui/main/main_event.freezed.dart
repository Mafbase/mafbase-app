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
    required TResult Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)
        switchTab,
    required TResult Function() backButtonPressed,
    required TResult Function() onPageOpened,
    required TResult Function(int tournamentId) tournamentSelected,
    required TResult Function() onTitleTapped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)?
        switchTab,
    TResult? Function()? backButtonPressed,
    TResult? Function()? onPageOpened,
    TResult? Function(int tournamentId)? tournamentSelected,
    TResult? Function()? onTitleTapped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)?
        switchTab,
    TResult Function()? backButtonPressed,
    TResult Function()? onPageOpened,
    TResult Function(int tournamentId)? tournamentSelected,
    TResult Function()? onTitleTapped,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MainEventSwitchTab value) switchTab,
    required TResult Function(MainEventBackButtonPressed value)
        backButtonPressed,
    required TResult Function(MainEventPageOpened value) onPageOpened,
    required TResult Function(MainEventTournamentSelected value)
        tournamentSelected,
    required TResult Function(MainEventTitleTapped value) onTitleTapped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainEventSwitchTab value)? switchTab,
    TResult? Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult? Function(MainEventPageOpened value)? onPageOpened,
    TResult? Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult? Function(MainEventTitleTapped value)? onTitleTapped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainEventSwitchTab value)? switchTab,
    TResult Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult Function(MainEventPageOpened value)? onPageOpened,
    TResult Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult Function(MainEventTitleTapped value)? onTitleTapped,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainEventCopyWith<$Res> {
  factory $MainEventCopyWith(MainEvent value, $Res Function(MainEvent) then) =
      _$MainEventCopyWithImpl<$Res, MainEvent>;
}

/// @nodoc
class _$MainEventCopyWithImpl<$Res, $Val extends MainEvent>
    implements $MainEventCopyWith<$Res> {
  _$MainEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MainEventSwitchTabCopyWith<$Res> {
  factory _$$MainEventSwitchTabCopyWith(_$MainEventSwitchTab value,
          $Res Function(_$MainEventSwitchTab) then) =
      __$$MainEventSwitchTabCopyWithImpl<$Res>;
  @useResult
  $Res call({MainPageTab tab, dynamic disableNavigate, bool hasBackButton});
}

/// @nodoc
class __$$MainEventSwitchTabCopyWithImpl<$Res>
    extends _$MainEventCopyWithImpl<$Res, _$MainEventSwitchTab>
    implements _$$MainEventSwitchTabCopyWith<$Res> {
  __$$MainEventSwitchTabCopyWithImpl(
      _$MainEventSwitchTab _value, $Res Function(_$MainEventSwitchTab) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tab = null,
    Object? disableNavigate = null,
    Object? hasBackButton = null,
  }) {
    return _then(_$MainEventSwitchTab(
      tab: null == tab
          ? _value.tab
          : tab // ignore: cast_nullable_to_non_nullable
              as MainPageTab,
      disableNavigate:
          null == disableNavigate ? _value.disableNavigate : disableNavigate,
      hasBackButton: null == hasBackButton
          ? _value.hasBackButton
          : hasBackButton // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$MainEventSwitchTab implements MainEventSwitchTab {
  const _$MainEventSwitchTab(
      {required this.tab,
      this.disableNavigate = false,
      this.hasBackButton = true});

  @override
  final MainPageTab tab;
  @override
  @JsonKey()
  final dynamic disableNavigate;
  @override
  @JsonKey()
  final bool hasBackButton;

  @override
  String toString() {
    return 'MainEvent.switchTab(tab: $tab, disableNavigate: $disableNavigate, hasBackButton: $hasBackButton)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainEventSwitchTab &&
            (identical(other.tab, tab) || other.tab == tab) &&
            const DeepCollectionEquality()
                .equals(other.disableNavigate, disableNavigate) &&
            (identical(other.hasBackButton, hasBackButton) ||
                other.hasBackButton == hasBackButton));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tab,
      const DeepCollectionEquality().hash(disableNavigate), hasBackButton);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MainEventSwitchTabCopyWith<_$MainEventSwitchTab> get copyWith =>
      __$$MainEventSwitchTabCopyWithImpl<_$MainEventSwitchTab>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)
        switchTab,
    required TResult Function() backButtonPressed,
    required TResult Function() onPageOpened,
    required TResult Function(int tournamentId) tournamentSelected,
    required TResult Function() onTitleTapped,
  }) {
    return switchTab(tab, disableNavigate, hasBackButton);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)?
        switchTab,
    TResult? Function()? backButtonPressed,
    TResult? Function()? onPageOpened,
    TResult? Function(int tournamentId)? tournamentSelected,
    TResult? Function()? onTitleTapped,
  }) {
    return switchTab?.call(tab, disableNavigate, hasBackButton);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)?
        switchTab,
    TResult Function()? backButtonPressed,
    TResult Function()? onPageOpened,
    TResult Function(int tournamentId)? tournamentSelected,
    TResult Function()? onTitleTapped,
    required TResult orElse(),
  }) {
    if (switchTab != null) {
      return switchTab(tab, disableNavigate, hasBackButton);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MainEventSwitchTab value) switchTab,
    required TResult Function(MainEventBackButtonPressed value)
        backButtonPressed,
    required TResult Function(MainEventPageOpened value) onPageOpened,
    required TResult Function(MainEventTournamentSelected value)
        tournamentSelected,
    required TResult Function(MainEventTitleTapped value) onTitleTapped,
  }) {
    return switchTab(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainEventSwitchTab value)? switchTab,
    TResult? Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult? Function(MainEventPageOpened value)? onPageOpened,
    TResult? Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult? Function(MainEventTitleTapped value)? onTitleTapped,
  }) {
    return switchTab?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainEventSwitchTab value)? switchTab,
    TResult Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult Function(MainEventPageOpened value)? onPageOpened,
    TResult Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult Function(MainEventTitleTapped value)? onTitleTapped,
    required TResult orElse(),
  }) {
    if (switchTab != null) {
      return switchTab(this);
    }
    return orElse();
  }
}

abstract class MainEventSwitchTab implements MainEvent {
  const factory MainEventSwitchTab(
      {required final MainPageTab tab,
      final dynamic disableNavigate,
      final bool hasBackButton}) = _$MainEventSwitchTab;

  MainPageTab get tab;
  dynamic get disableNavigate;
  bool get hasBackButton;
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
    extends _$MainEventCopyWithImpl<$Res, _$MainEventBackButtonPressed>
    implements _$$MainEventBackButtonPressedCopyWith<$Res> {
  __$$MainEventBackButtonPressedCopyWithImpl(
      _$MainEventBackButtonPressed _value,
      $Res Function(_$MainEventBackButtonPressed) _then)
      : super(_value, _then);
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
    required TResult Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)
        switchTab,
    required TResult Function() backButtonPressed,
    required TResult Function() onPageOpened,
    required TResult Function(int tournamentId) tournamentSelected,
    required TResult Function() onTitleTapped,
  }) {
    return backButtonPressed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)?
        switchTab,
    TResult? Function()? backButtonPressed,
    TResult? Function()? onPageOpened,
    TResult? Function(int tournamentId)? tournamentSelected,
    TResult? Function()? onTitleTapped,
  }) {
    return backButtonPressed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)?
        switchTab,
    TResult Function()? backButtonPressed,
    TResult Function()? onPageOpened,
    TResult Function(int tournamentId)? tournamentSelected,
    TResult Function()? onTitleTapped,
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
    required TResult Function(MainEventPageOpened value) onPageOpened,
    required TResult Function(MainEventTournamentSelected value)
        tournamentSelected,
    required TResult Function(MainEventTitleTapped value) onTitleTapped,
  }) {
    return backButtonPressed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainEventSwitchTab value)? switchTab,
    TResult? Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult? Function(MainEventPageOpened value)? onPageOpened,
    TResult? Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult? Function(MainEventTitleTapped value)? onTitleTapped,
  }) {
    return backButtonPressed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainEventSwitchTab value)? switchTab,
    TResult Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult Function(MainEventPageOpened value)? onPageOpened,
    TResult Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult Function(MainEventTitleTapped value)? onTitleTapped,
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

/// @nodoc
abstract class _$$MainEventPageOpenedCopyWith<$Res> {
  factory _$$MainEventPageOpenedCopyWith(_$MainEventPageOpened value,
          $Res Function(_$MainEventPageOpened) then) =
      __$$MainEventPageOpenedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MainEventPageOpenedCopyWithImpl<$Res>
    extends _$MainEventCopyWithImpl<$Res, _$MainEventPageOpened>
    implements _$$MainEventPageOpenedCopyWith<$Res> {
  __$$MainEventPageOpenedCopyWithImpl(
      _$MainEventPageOpened _value, $Res Function(_$MainEventPageOpened) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MainEventPageOpened implements MainEventPageOpened {
  const _$MainEventPageOpened();

  @override
  String toString() {
    return 'MainEvent.onPageOpened()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MainEventPageOpened);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)
        switchTab,
    required TResult Function() backButtonPressed,
    required TResult Function() onPageOpened,
    required TResult Function(int tournamentId) tournamentSelected,
    required TResult Function() onTitleTapped,
  }) {
    return onPageOpened();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)?
        switchTab,
    TResult? Function()? backButtonPressed,
    TResult? Function()? onPageOpened,
    TResult? Function(int tournamentId)? tournamentSelected,
    TResult? Function()? onTitleTapped,
  }) {
    return onPageOpened?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)?
        switchTab,
    TResult Function()? backButtonPressed,
    TResult Function()? onPageOpened,
    TResult Function(int tournamentId)? tournamentSelected,
    TResult Function()? onTitleTapped,
    required TResult orElse(),
  }) {
    if (onPageOpened != null) {
      return onPageOpened();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MainEventSwitchTab value) switchTab,
    required TResult Function(MainEventBackButtonPressed value)
        backButtonPressed,
    required TResult Function(MainEventPageOpened value) onPageOpened,
    required TResult Function(MainEventTournamentSelected value)
        tournamentSelected,
    required TResult Function(MainEventTitleTapped value) onTitleTapped,
  }) {
    return onPageOpened(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainEventSwitchTab value)? switchTab,
    TResult? Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult? Function(MainEventPageOpened value)? onPageOpened,
    TResult? Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult? Function(MainEventTitleTapped value)? onTitleTapped,
  }) {
    return onPageOpened?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainEventSwitchTab value)? switchTab,
    TResult Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult Function(MainEventPageOpened value)? onPageOpened,
    TResult Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult Function(MainEventTitleTapped value)? onTitleTapped,
    required TResult orElse(),
  }) {
    if (onPageOpened != null) {
      return onPageOpened(this);
    }
    return orElse();
  }
}

abstract class MainEventPageOpened implements MainEvent {
  const factory MainEventPageOpened() = _$MainEventPageOpened;
}

/// @nodoc
abstract class _$$MainEventTournamentSelectedCopyWith<$Res> {
  factory _$$MainEventTournamentSelectedCopyWith(
          _$MainEventTournamentSelected value,
          $Res Function(_$MainEventTournamentSelected) then) =
      __$$MainEventTournamentSelectedCopyWithImpl<$Res>;
  @useResult
  $Res call({int tournamentId});
}

/// @nodoc
class __$$MainEventTournamentSelectedCopyWithImpl<$Res>
    extends _$MainEventCopyWithImpl<$Res, _$MainEventTournamentSelected>
    implements _$$MainEventTournamentSelectedCopyWith<$Res> {
  __$$MainEventTournamentSelectedCopyWithImpl(
      _$MainEventTournamentSelected _value,
      $Res Function(_$MainEventTournamentSelected) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tournamentId = null,
  }) {
    return _then(_$MainEventTournamentSelected(
      tournamentId: null == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$MainEventTournamentSelected implements MainEventTournamentSelected {
  const _$MainEventTournamentSelected({required this.tournamentId});

  @override
  final int tournamentId;

  @override
  String toString() {
    return 'MainEvent.tournamentSelected(tournamentId: $tournamentId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainEventTournamentSelected &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tournamentId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MainEventTournamentSelectedCopyWith<_$MainEventTournamentSelected>
      get copyWith => __$$MainEventTournamentSelectedCopyWithImpl<
          _$MainEventTournamentSelected>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)
        switchTab,
    required TResult Function() backButtonPressed,
    required TResult Function() onPageOpened,
    required TResult Function(int tournamentId) tournamentSelected,
    required TResult Function() onTitleTapped,
  }) {
    return tournamentSelected(tournamentId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)?
        switchTab,
    TResult? Function()? backButtonPressed,
    TResult? Function()? onPageOpened,
    TResult? Function(int tournamentId)? tournamentSelected,
    TResult? Function()? onTitleTapped,
  }) {
    return tournamentSelected?.call(tournamentId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)?
        switchTab,
    TResult Function()? backButtonPressed,
    TResult Function()? onPageOpened,
    TResult Function(int tournamentId)? tournamentSelected,
    TResult Function()? onTitleTapped,
    required TResult orElse(),
  }) {
    if (tournamentSelected != null) {
      return tournamentSelected(tournamentId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MainEventSwitchTab value) switchTab,
    required TResult Function(MainEventBackButtonPressed value)
        backButtonPressed,
    required TResult Function(MainEventPageOpened value) onPageOpened,
    required TResult Function(MainEventTournamentSelected value)
        tournamentSelected,
    required TResult Function(MainEventTitleTapped value) onTitleTapped,
  }) {
    return tournamentSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainEventSwitchTab value)? switchTab,
    TResult? Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult? Function(MainEventPageOpened value)? onPageOpened,
    TResult? Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult? Function(MainEventTitleTapped value)? onTitleTapped,
  }) {
    return tournamentSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainEventSwitchTab value)? switchTab,
    TResult Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult Function(MainEventPageOpened value)? onPageOpened,
    TResult Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult Function(MainEventTitleTapped value)? onTitleTapped,
    required TResult orElse(),
  }) {
    if (tournamentSelected != null) {
      return tournamentSelected(this);
    }
    return orElse();
  }
}

abstract class MainEventTournamentSelected implements MainEvent {
  const factory MainEventTournamentSelected({required final int tournamentId}) =
      _$MainEventTournamentSelected;

  int get tournamentId;
  @JsonKey(ignore: true)
  _$$MainEventTournamentSelectedCopyWith<_$MainEventTournamentSelected>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MainEventTitleTappedCopyWith<$Res> {
  factory _$$MainEventTitleTappedCopyWith(_$MainEventTitleTapped value,
          $Res Function(_$MainEventTitleTapped) then) =
      __$$MainEventTitleTappedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MainEventTitleTappedCopyWithImpl<$Res>
    extends _$MainEventCopyWithImpl<$Res, _$MainEventTitleTapped>
    implements _$$MainEventTitleTappedCopyWith<$Res> {
  __$$MainEventTitleTappedCopyWithImpl(_$MainEventTitleTapped _value,
      $Res Function(_$MainEventTitleTapped) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MainEventTitleTapped implements MainEventTitleTapped {
  const _$MainEventTitleTapped();

  @override
  String toString() {
    return 'MainEvent.onTitleTapped()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MainEventTitleTapped);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)
        switchTab,
    required TResult Function() backButtonPressed,
    required TResult Function() onPageOpened,
    required TResult Function(int tournamentId) tournamentSelected,
    required TResult Function() onTitleTapped,
  }) {
    return onTitleTapped();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)?
        switchTab,
    TResult? Function()? backButtonPressed,
    TResult? Function()? onPageOpened,
    TResult? Function(int tournamentId)? tournamentSelected,
    TResult? Function()? onTitleTapped,
  }) {
    return onTitleTapped?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)?
        switchTab,
    TResult Function()? backButtonPressed,
    TResult Function()? onPageOpened,
    TResult Function(int tournamentId)? tournamentSelected,
    TResult Function()? onTitleTapped,
    required TResult orElse(),
  }) {
    if (onTitleTapped != null) {
      return onTitleTapped();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MainEventSwitchTab value) switchTab,
    required TResult Function(MainEventBackButtonPressed value)
        backButtonPressed,
    required TResult Function(MainEventPageOpened value) onPageOpened,
    required TResult Function(MainEventTournamentSelected value)
        tournamentSelected,
    required TResult Function(MainEventTitleTapped value) onTitleTapped,
  }) {
    return onTitleTapped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainEventSwitchTab value)? switchTab,
    TResult? Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult? Function(MainEventPageOpened value)? onPageOpened,
    TResult? Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult? Function(MainEventTitleTapped value)? onTitleTapped,
  }) {
    return onTitleTapped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainEventSwitchTab value)? switchTab,
    TResult Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult Function(MainEventPageOpened value)? onPageOpened,
    TResult Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult Function(MainEventTitleTapped value)? onTitleTapped,
    required TResult orElse(),
  }) {
    if (onTitleTapped != null) {
      return onTitleTapped(this);
    }
    return orElse();
  }
}

abstract class MainEventTitleTapped implements MainEvent {
  const factory MainEventTitleTapped() = _$MainEventTitleTapped;
}
