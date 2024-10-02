// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
    required TResult Function(int tournamentId) tournamentSelected,
    required TResult Function() onTitleTapped,
    required TResult Function() onEnterPressed,
    required TResult Function() onProfilePressed,
    required TResult Function() openContacts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)?
        switchTab,
    TResult? Function()? backButtonPressed,
    TResult? Function(int tournamentId)? tournamentSelected,
    TResult? Function()? onTitleTapped,
    TResult? Function()? onEnterPressed,
    TResult? Function()? onProfilePressed,
    TResult? Function()? openContacts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)?
        switchTab,
    TResult Function()? backButtonPressed,
    TResult Function(int tournamentId)? tournamentSelected,
    TResult Function()? onTitleTapped,
    TResult Function()? onEnterPressed,
    TResult Function()? onProfilePressed,
    TResult Function()? openContacts,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MainEventSwitchTab value) switchTab,
    required TResult Function(MainEventBackButtonPressed value)
        backButtonPressed,
    required TResult Function(MainEventTournamentSelected value)
        tournamentSelected,
    required TResult Function(MainEventTitleTapped value) onTitleTapped,
    required TResult Function(MainEventEnterPressed value) onEnterPressed,
    required TResult Function(MainEventProfilePressed value) onProfilePressed,
    required TResult Function(MainEventOpenContacts value) openContacts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainEventSwitchTab value)? switchTab,
    TResult? Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult? Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult? Function(MainEventTitleTapped value)? onTitleTapped,
    TResult? Function(MainEventEnterPressed value)? onEnterPressed,
    TResult? Function(MainEventProfilePressed value)? onProfilePressed,
    TResult? Function(MainEventOpenContacts value)? openContacts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainEventSwitchTab value)? switchTab,
    TResult Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult Function(MainEventTitleTapped value)? onTitleTapped,
    TResult Function(MainEventEnterPressed value)? onEnterPressed,
    TResult Function(MainEventProfilePressed value)? onProfilePressed,
    TResult Function(MainEventOpenContacts value)? openContacts,
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
abstract class _$$MainEventSwitchTabImplCopyWith<$Res> {
  factory _$$MainEventSwitchTabImplCopyWith(_$MainEventSwitchTabImpl value,
          $Res Function(_$MainEventSwitchTabImpl) then) =
      __$$MainEventSwitchTabImplCopyWithImpl<$Res>;
  @useResult
  $Res call({MainPageTab tab, dynamic disableNavigate, bool hasBackButton});
}

/// @nodoc
class __$$MainEventSwitchTabImplCopyWithImpl<$Res>
    extends _$MainEventCopyWithImpl<$Res, _$MainEventSwitchTabImpl>
    implements _$$MainEventSwitchTabImplCopyWith<$Res> {
  __$$MainEventSwitchTabImplCopyWithImpl(_$MainEventSwitchTabImpl _value,
      $Res Function(_$MainEventSwitchTabImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tab = null,
    Object? disableNavigate = freezed,
    Object? hasBackButton = null,
  }) {
    return _then(_$MainEventSwitchTabImpl(
      tab: null == tab
          ? _value.tab
          : tab // ignore: cast_nullable_to_non_nullable
              as MainPageTab,
      disableNavigate: freezed == disableNavigate
          ? _value.disableNavigate!
          : disableNavigate,
      hasBackButton: null == hasBackButton
          ? _value.hasBackButton
          : hasBackButton // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$MainEventSwitchTabImpl implements MainEventSwitchTab {
  const _$MainEventSwitchTabImpl(
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainEventSwitchTabImpl &&
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
  _$$MainEventSwitchTabImplCopyWith<_$MainEventSwitchTabImpl> get copyWith =>
      __$$MainEventSwitchTabImplCopyWithImpl<_$MainEventSwitchTabImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)
        switchTab,
    required TResult Function() backButtonPressed,
    required TResult Function(int tournamentId) tournamentSelected,
    required TResult Function() onTitleTapped,
    required TResult Function() onEnterPressed,
    required TResult Function() onProfilePressed,
    required TResult Function() openContacts,
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
    TResult? Function(int tournamentId)? tournamentSelected,
    TResult? Function()? onTitleTapped,
    TResult? Function()? onEnterPressed,
    TResult? Function()? onProfilePressed,
    TResult? Function()? openContacts,
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
    TResult Function(int tournamentId)? tournamentSelected,
    TResult Function()? onTitleTapped,
    TResult Function()? onEnterPressed,
    TResult Function()? onProfilePressed,
    TResult Function()? openContacts,
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
    required TResult Function(MainEventTournamentSelected value)
        tournamentSelected,
    required TResult Function(MainEventTitleTapped value) onTitleTapped,
    required TResult Function(MainEventEnterPressed value) onEnterPressed,
    required TResult Function(MainEventProfilePressed value) onProfilePressed,
    required TResult Function(MainEventOpenContacts value) openContacts,
  }) {
    return switchTab(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainEventSwitchTab value)? switchTab,
    TResult? Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult? Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult? Function(MainEventTitleTapped value)? onTitleTapped,
    TResult? Function(MainEventEnterPressed value)? onEnterPressed,
    TResult? Function(MainEventProfilePressed value)? onProfilePressed,
    TResult? Function(MainEventOpenContacts value)? openContacts,
  }) {
    return switchTab?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainEventSwitchTab value)? switchTab,
    TResult Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult Function(MainEventTitleTapped value)? onTitleTapped,
    TResult Function(MainEventEnterPressed value)? onEnterPressed,
    TResult Function(MainEventProfilePressed value)? onProfilePressed,
    TResult Function(MainEventOpenContacts value)? openContacts,
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
      final bool hasBackButton}) = _$MainEventSwitchTabImpl;

  MainPageTab get tab;
  dynamic get disableNavigate;
  bool get hasBackButton;
  @JsonKey(ignore: true)
  _$$MainEventSwitchTabImplCopyWith<_$MainEventSwitchTabImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MainEventBackButtonPressedImplCopyWith<$Res> {
  factory _$$MainEventBackButtonPressedImplCopyWith(
          _$MainEventBackButtonPressedImpl value,
          $Res Function(_$MainEventBackButtonPressedImpl) then) =
      __$$MainEventBackButtonPressedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MainEventBackButtonPressedImplCopyWithImpl<$Res>
    extends _$MainEventCopyWithImpl<$Res, _$MainEventBackButtonPressedImpl>
    implements _$$MainEventBackButtonPressedImplCopyWith<$Res> {
  __$$MainEventBackButtonPressedImplCopyWithImpl(
      _$MainEventBackButtonPressedImpl _value,
      $Res Function(_$MainEventBackButtonPressedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MainEventBackButtonPressedImpl implements MainEventBackButtonPressed {
  const _$MainEventBackButtonPressedImpl();

  @override
  String toString() {
    return 'MainEvent.backButtonPressed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainEventBackButtonPressedImpl);
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
    required TResult Function(int tournamentId) tournamentSelected,
    required TResult Function() onTitleTapped,
    required TResult Function() onEnterPressed,
    required TResult Function() onProfilePressed,
    required TResult Function() openContacts,
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
    TResult? Function(int tournamentId)? tournamentSelected,
    TResult? Function()? onTitleTapped,
    TResult? Function()? onEnterPressed,
    TResult? Function()? onProfilePressed,
    TResult? Function()? openContacts,
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
    TResult Function(int tournamentId)? tournamentSelected,
    TResult Function()? onTitleTapped,
    TResult Function()? onEnterPressed,
    TResult Function()? onProfilePressed,
    TResult Function()? openContacts,
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
    required TResult Function(MainEventTournamentSelected value)
        tournamentSelected,
    required TResult Function(MainEventTitleTapped value) onTitleTapped,
    required TResult Function(MainEventEnterPressed value) onEnterPressed,
    required TResult Function(MainEventProfilePressed value) onProfilePressed,
    required TResult Function(MainEventOpenContacts value) openContacts,
  }) {
    return backButtonPressed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainEventSwitchTab value)? switchTab,
    TResult? Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult? Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult? Function(MainEventTitleTapped value)? onTitleTapped,
    TResult? Function(MainEventEnterPressed value)? onEnterPressed,
    TResult? Function(MainEventProfilePressed value)? onProfilePressed,
    TResult? Function(MainEventOpenContacts value)? openContacts,
  }) {
    return backButtonPressed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainEventSwitchTab value)? switchTab,
    TResult Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult Function(MainEventTitleTapped value)? onTitleTapped,
    TResult Function(MainEventEnterPressed value)? onEnterPressed,
    TResult Function(MainEventProfilePressed value)? onProfilePressed,
    TResult Function(MainEventOpenContacts value)? openContacts,
    required TResult orElse(),
  }) {
    if (backButtonPressed != null) {
      return backButtonPressed(this);
    }
    return orElse();
  }
}

abstract class MainEventBackButtonPressed implements MainEvent {
  const factory MainEventBackButtonPressed() = _$MainEventBackButtonPressedImpl;
}

/// @nodoc
abstract class _$$MainEventTournamentSelectedImplCopyWith<$Res> {
  factory _$$MainEventTournamentSelectedImplCopyWith(
          _$MainEventTournamentSelectedImpl value,
          $Res Function(_$MainEventTournamentSelectedImpl) then) =
      __$$MainEventTournamentSelectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int tournamentId});
}

/// @nodoc
class __$$MainEventTournamentSelectedImplCopyWithImpl<$Res>
    extends _$MainEventCopyWithImpl<$Res, _$MainEventTournamentSelectedImpl>
    implements _$$MainEventTournamentSelectedImplCopyWith<$Res> {
  __$$MainEventTournamentSelectedImplCopyWithImpl(
      _$MainEventTournamentSelectedImpl _value,
      $Res Function(_$MainEventTournamentSelectedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tournamentId = null,
  }) {
    return _then(_$MainEventTournamentSelectedImpl(
      tournamentId: null == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$MainEventTournamentSelectedImpl implements MainEventTournamentSelected {
  const _$MainEventTournamentSelectedImpl({required this.tournamentId});

  @override
  final int tournamentId;

  @override
  String toString() {
    return 'MainEvent.tournamentSelected(tournamentId: $tournamentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainEventTournamentSelectedImpl &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tournamentId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MainEventTournamentSelectedImplCopyWith<_$MainEventTournamentSelectedImpl>
      get copyWith => __$$MainEventTournamentSelectedImplCopyWithImpl<
          _$MainEventTournamentSelectedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)
        switchTab,
    required TResult Function() backButtonPressed,
    required TResult Function(int tournamentId) tournamentSelected,
    required TResult Function() onTitleTapped,
    required TResult Function() onEnterPressed,
    required TResult Function() onProfilePressed,
    required TResult Function() openContacts,
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
    TResult? Function(int tournamentId)? tournamentSelected,
    TResult? Function()? onTitleTapped,
    TResult? Function()? onEnterPressed,
    TResult? Function()? onProfilePressed,
    TResult? Function()? openContacts,
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
    TResult Function(int tournamentId)? tournamentSelected,
    TResult Function()? onTitleTapped,
    TResult Function()? onEnterPressed,
    TResult Function()? onProfilePressed,
    TResult Function()? openContacts,
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
    required TResult Function(MainEventTournamentSelected value)
        tournamentSelected,
    required TResult Function(MainEventTitleTapped value) onTitleTapped,
    required TResult Function(MainEventEnterPressed value) onEnterPressed,
    required TResult Function(MainEventProfilePressed value) onProfilePressed,
    required TResult Function(MainEventOpenContacts value) openContacts,
  }) {
    return tournamentSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainEventSwitchTab value)? switchTab,
    TResult? Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult? Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult? Function(MainEventTitleTapped value)? onTitleTapped,
    TResult? Function(MainEventEnterPressed value)? onEnterPressed,
    TResult? Function(MainEventProfilePressed value)? onProfilePressed,
    TResult? Function(MainEventOpenContacts value)? openContacts,
  }) {
    return tournamentSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainEventSwitchTab value)? switchTab,
    TResult Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult Function(MainEventTitleTapped value)? onTitleTapped,
    TResult Function(MainEventEnterPressed value)? onEnterPressed,
    TResult Function(MainEventProfilePressed value)? onProfilePressed,
    TResult Function(MainEventOpenContacts value)? openContacts,
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
      _$MainEventTournamentSelectedImpl;

  int get tournamentId;
  @JsonKey(ignore: true)
  _$$MainEventTournamentSelectedImplCopyWith<_$MainEventTournamentSelectedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MainEventTitleTappedImplCopyWith<$Res> {
  factory _$$MainEventTitleTappedImplCopyWith(_$MainEventTitleTappedImpl value,
          $Res Function(_$MainEventTitleTappedImpl) then) =
      __$$MainEventTitleTappedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MainEventTitleTappedImplCopyWithImpl<$Res>
    extends _$MainEventCopyWithImpl<$Res, _$MainEventTitleTappedImpl>
    implements _$$MainEventTitleTappedImplCopyWith<$Res> {
  __$$MainEventTitleTappedImplCopyWithImpl(_$MainEventTitleTappedImpl _value,
      $Res Function(_$MainEventTitleTappedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MainEventTitleTappedImpl implements MainEventTitleTapped {
  const _$MainEventTitleTappedImpl();

  @override
  String toString() {
    return 'MainEvent.onTitleTapped()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainEventTitleTappedImpl);
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
    required TResult Function(int tournamentId) tournamentSelected,
    required TResult Function() onTitleTapped,
    required TResult Function() onEnterPressed,
    required TResult Function() onProfilePressed,
    required TResult Function() openContacts,
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
    TResult? Function(int tournamentId)? tournamentSelected,
    TResult? Function()? onTitleTapped,
    TResult? Function()? onEnterPressed,
    TResult? Function()? onProfilePressed,
    TResult? Function()? openContacts,
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
    TResult Function(int tournamentId)? tournamentSelected,
    TResult Function()? onTitleTapped,
    TResult Function()? onEnterPressed,
    TResult Function()? onProfilePressed,
    TResult Function()? openContacts,
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
    required TResult Function(MainEventTournamentSelected value)
        tournamentSelected,
    required TResult Function(MainEventTitleTapped value) onTitleTapped,
    required TResult Function(MainEventEnterPressed value) onEnterPressed,
    required TResult Function(MainEventProfilePressed value) onProfilePressed,
    required TResult Function(MainEventOpenContacts value) openContacts,
  }) {
    return onTitleTapped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainEventSwitchTab value)? switchTab,
    TResult? Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult? Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult? Function(MainEventTitleTapped value)? onTitleTapped,
    TResult? Function(MainEventEnterPressed value)? onEnterPressed,
    TResult? Function(MainEventProfilePressed value)? onProfilePressed,
    TResult? Function(MainEventOpenContacts value)? openContacts,
  }) {
    return onTitleTapped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainEventSwitchTab value)? switchTab,
    TResult Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult Function(MainEventTitleTapped value)? onTitleTapped,
    TResult Function(MainEventEnterPressed value)? onEnterPressed,
    TResult Function(MainEventProfilePressed value)? onProfilePressed,
    TResult Function(MainEventOpenContacts value)? openContacts,
    required TResult orElse(),
  }) {
    if (onTitleTapped != null) {
      return onTitleTapped(this);
    }
    return orElse();
  }
}

abstract class MainEventTitleTapped implements MainEvent {
  const factory MainEventTitleTapped() = _$MainEventTitleTappedImpl;
}

/// @nodoc
abstract class _$$MainEventEnterPressedImplCopyWith<$Res> {
  factory _$$MainEventEnterPressedImplCopyWith(
          _$MainEventEnterPressedImpl value,
          $Res Function(_$MainEventEnterPressedImpl) then) =
      __$$MainEventEnterPressedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MainEventEnterPressedImplCopyWithImpl<$Res>
    extends _$MainEventCopyWithImpl<$Res, _$MainEventEnterPressedImpl>
    implements _$$MainEventEnterPressedImplCopyWith<$Res> {
  __$$MainEventEnterPressedImplCopyWithImpl(_$MainEventEnterPressedImpl _value,
      $Res Function(_$MainEventEnterPressedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MainEventEnterPressedImpl implements MainEventEnterPressed {
  const _$MainEventEnterPressedImpl();

  @override
  String toString() {
    return 'MainEvent.onEnterPressed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainEventEnterPressedImpl);
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
    required TResult Function(int tournamentId) tournamentSelected,
    required TResult Function() onTitleTapped,
    required TResult Function() onEnterPressed,
    required TResult Function() onProfilePressed,
    required TResult Function() openContacts,
  }) {
    return onEnterPressed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)?
        switchTab,
    TResult? Function()? backButtonPressed,
    TResult? Function(int tournamentId)? tournamentSelected,
    TResult? Function()? onTitleTapped,
    TResult? Function()? onEnterPressed,
    TResult? Function()? onProfilePressed,
    TResult? Function()? openContacts,
  }) {
    return onEnterPressed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)?
        switchTab,
    TResult Function()? backButtonPressed,
    TResult Function(int tournamentId)? tournamentSelected,
    TResult Function()? onTitleTapped,
    TResult Function()? onEnterPressed,
    TResult Function()? onProfilePressed,
    TResult Function()? openContacts,
    required TResult orElse(),
  }) {
    if (onEnterPressed != null) {
      return onEnterPressed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MainEventSwitchTab value) switchTab,
    required TResult Function(MainEventBackButtonPressed value)
        backButtonPressed,
    required TResult Function(MainEventTournamentSelected value)
        tournamentSelected,
    required TResult Function(MainEventTitleTapped value) onTitleTapped,
    required TResult Function(MainEventEnterPressed value) onEnterPressed,
    required TResult Function(MainEventProfilePressed value) onProfilePressed,
    required TResult Function(MainEventOpenContacts value) openContacts,
  }) {
    return onEnterPressed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainEventSwitchTab value)? switchTab,
    TResult? Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult? Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult? Function(MainEventTitleTapped value)? onTitleTapped,
    TResult? Function(MainEventEnterPressed value)? onEnterPressed,
    TResult? Function(MainEventProfilePressed value)? onProfilePressed,
    TResult? Function(MainEventOpenContacts value)? openContacts,
  }) {
    return onEnterPressed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainEventSwitchTab value)? switchTab,
    TResult Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult Function(MainEventTitleTapped value)? onTitleTapped,
    TResult Function(MainEventEnterPressed value)? onEnterPressed,
    TResult Function(MainEventProfilePressed value)? onProfilePressed,
    TResult Function(MainEventOpenContacts value)? openContacts,
    required TResult orElse(),
  }) {
    if (onEnterPressed != null) {
      return onEnterPressed(this);
    }
    return orElse();
  }
}

abstract class MainEventEnterPressed implements MainEvent {
  const factory MainEventEnterPressed() = _$MainEventEnterPressedImpl;
}

/// @nodoc
abstract class _$$MainEventProfilePressedImplCopyWith<$Res> {
  factory _$$MainEventProfilePressedImplCopyWith(
          _$MainEventProfilePressedImpl value,
          $Res Function(_$MainEventProfilePressedImpl) then) =
      __$$MainEventProfilePressedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MainEventProfilePressedImplCopyWithImpl<$Res>
    extends _$MainEventCopyWithImpl<$Res, _$MainEventProfilePressedImpl>
    implements _$$MainEventProfilePressedImplCopyWith<$Res> {
  __$$MainEventProfilePressedImplCopyWithImpl(
      _$MainEventProfilePressedImpl _value,
      $Res Function(_$MainEventProfilePressedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MainEventProfilePressedImpl implements MainEventProfilePressed {
  const _$MainEventProfilePressedImpl();

  @override
  String toString() {
    return 'MainEvent.onProfilePressed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainEventProfilePressedImpl);
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
    required TResult Function(int tournamentId) tournamentSelected,
    required TResult Function() onTitleTapped,
    required TResult Function() onEnterPressed,
    required TResult Function() onProfilePressed,
    required TResult Function() openContacts,
  }) {
    return onProfilePressed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)?
        switchTab,
    TResult? Function()? backButtonPressed,
    TResult? Function(int tournamentId)? tournamentSelected,
    TResult? Function()? onTitleTapped,
    TResult? Function()? onEnterPressed,
    TResult? Function()? onProfilePressed,
    TResult? Function()? openContacts,
  }) {
    return onProfilePressed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)?
        switchTab,
    TResult Function()? backButtonPressed,
    TResult Function(int tournamentId)? tournamentSelected,
    TResult Function()? onTitleTapped,
    TResult Function()? onEnterPressed,
    TResult Function()? onProfilePressed,
    TResult Function()? openContacts,
    required TResult orElse(),
  }) {
    if (onProfilePressed != null) {
      return onProfilePressed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MainEventSwitchTab value) switchTab,
    required TResult Function(MainEventBackButtonPressed value)
        backButtonPressed,
    required TResult Function(MainEventTournamentSelected value)
        tournamentSelected,
    required TResult Function(MainEventTitleTapped value) onTitleTapped,
    required TResult Function(MainEventEnterPressed value) onEnterPressed,
    required TResult Function(MainEventProfilePressed value) onProfilePressed,
    required TResult Function(MainEventOpenContacts value) openContacts,
  }) {
    return onProfilePressed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainEventSwitchTab value)? switchTab,
    TResult? Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult? Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult? Function(MainEventTitleTapped value)? onTitleTapped,
    TResult? Function(MainEventEnterPressed value)? onEnterPressed,
    TResult? Function(MainEventProfilePressed value)? onProfilePressed,
    TResult? Function(MainEventOpenContacts value)? openContacts,
  }) {
    return onProfilePressed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainEventSwitchTab value)? switchTab,
    TResult Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult Function(MainEventTitleTapped value)? onTitleTapped,
    TResult Function(MainEventEnterPressed value)? onEnterPressed,
    TResult Function(MainEventProfilePressed value)? onProfilePressed,
    TResult Function(MainEventOpenContacts value)? openContacts,
    required TResult orElse(),
  }) {
    if (onProfilePressed != null) {
      return onProfilePressed(this);
    }
    return orElse();
  }
}

abstract class MainEventProfilePressed implements MainEvent {
  const factory MainEventProfilePressed() = _$MainEventProfilePressedImpl;
}

/// @nodoc
abstract class _$$MainEventOpenContactsImplCopyWith<$Res> {
  factory _$$MainEventOpenContactsImplCopyWith(
          _$MainEventOpenContactsImpl value,
          $Res Function(_$MainEventOpenContactsImpl) then) =
      __$$MainEventOpenContactsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MainEventOpenContactsImplCopyWithImpl<$Res>
    extends _$MainEventCopyWithImpl<$Res, _$MainEventOpenContactsImpl>
    implements _$$MainEventOpenContactsImplCopyWith<$Res> {
  __$$MainEventOpenContactsImplCopyWithImpl(_$MainEventOpenContactsImpl _value,
      $Res Function(_$MainEventOpenContactsImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MainEventOpenContactsImpl implements MainEventOpenContacts {
  const _$MainEventOpenContactsImpl();

  @override
  String toString() {
    return 'MainEvent.openContacts()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainEventOpenContactsImpl);
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
    required TResult Function(int tournamentId) tournamentSelected,
    required TResult Function() onTitleTapped,
    required TResult Function() onEnterPressed,
    required TResult Function() onProfilePressed,
    required TResult Function() openContacts,
  }) {
    return openContacts();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)?
        switchTab,
    TResult? Function()? backButtonPressed,
    TResult? Function(int tournamentId)? tournamentSelected,
    TResult? Function()? onTitleTapped,
    TResult? Function()? onEnterPressed,
    TResult? Function()? onProfilePressed,
    TResult? Function()? openContacts,
  }) {
    return openContacts?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            MainPageTab tab, dynamic disableNavigate, bool hasBackButton)?
        switchTab,
    TResult Function()? backButtonPressed,
    TResult Function(int tournamentId)? tournamentSelected,
    TResult Function()? onTitleTapped,
    TResult Function()? onEnterPressed,
    TResult Function()? onProfilePressed,
    TResult Function()? openContacts,
    required TResult orElse(),
  }) {
    if (openContacts != null) {
      return openContacts();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MainEventSwitchTab value) switchTab,
    required TResult Function(MainEventBackButtonPressed value)
        backButtonPressed,
    required TResult Function(MainEventTournamentSelected value)
        tournamentSelected,
    required TResult Function(MainEventTitleTapped value) onTitleTapped,
    required TResult Function(MainEventEnterPressed value) onEnterPressed,
    required TResult Function(MainEventProfilePressed value) onProfilePressed,
    required TResult Function(MainEventOpenContacts value) openContacts,
  }) {
    return openContacts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainEventSwitchTab value)? switchTab,
    TResult? Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult? Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult? Function(MainEventTitleTapped value)? onTitleTapped,
    TResult? Function(MainEventEnterPressed value)? onEnterPressed,
    TResult? Function(MainEventProfilePressed value)? onProfilePressed,
    TResult? Function(MainEventOpenContacts value)? openContacts,
  }) {
    return openContacts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainEventSwitchTab value)? switchTab,
    TResult Function(MainEventBackButtonPressed value)? backButtonPressed,
    TResult Function(MainEventTournamentSelected value)? tournamentSelected,
    TResult Function(MainEventTitleTapped value)? onTitleTapped,
    TResult Function(MainEventEnterPressed value)? onEnterPressed,
    TResult Function(MainEventProfilePressed value)? onProfilePressed,
    TResult Function(MainEventOpenContacts value)? openContacts,
    required TResult orElse(),
  }) {
    if (openContacts != null) {
      return openContacts(this);
    }
    return orElse();
  }
}

abstract class MainEventOpenContacts implements MainEvent {
  const factory MainEventOpenContacts() = _$MainEventOpenContactsImpl;
}
