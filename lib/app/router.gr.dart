// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [AdministrationPage]
class AdministrationRoute extends PageRouteInfo<AdministrationRouteArgs> {
  AdministrationRoute({
    Key? key,
    required int tournamentId,
    List<PageRouteInfo>? children,
  }) : super(
          AdministrationRoute.name,
          args: AdministrationRouteArgs(key: key, tournamentId: tournamentId),
          rawPathParams: {'id': tournamentId},
          initialChildren: children,
        );

  static const String name = 'AdministrationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<AdministrationRouteArgs>(
        orElse: () =>
            AdministrationRouteArgs(tournamentId: pathParams.getInt('id')),
      );
      return AdministrationPage(key: args.key, tournamentId: args.tournamentId);
    },
  );
}

class AdministrationRouteArgs {
  const AdministrationRouteArgs({this.key, required this.tournamentId});

  final Key? key;

  final int tournamentId;

  @override
  String toString() {
    return 'AdministrationRouteArgs{key: $key, tournamentId: $tournamentId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AdministrationRouteArgs) return false;
    return key == other.key && tournamentId == other.tournamentId;
  }

  @override
  int get hashCode => key.hashCode ^ tournamentId.hashCode;
}

/// generated route for
/// [AppShellPage]
class AppShellRoute extends PageRouteInfo<void> {
  const AppShellRoute({List<PageRouteInfo>? children})
      : super(AppShellRoute.name, initialChildren: children);

  static const String name = 'AppShellRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppShellPage();
    },
  );
}

/// generated route for
/// [ClubGameDetailPage]
class ClubGameDetailRoute extends PageRouteInfo<ClubGameDetailRouteArgs> {
  ClubGameDetailRoute({
    Key? key,
    int? clubId,
    int? gameId,
    bool? editParam,
    List<PageRouteInfo>? children,
  }) : super(
          ClubGameDetailRoute.name,
          args: ClubGameDetailRouteArgs(
            key: key,
            clubId: clubId,
            gameId: gameId,
            editParam: editParam,
          ),
          rawPathParams: {'clubId': clubId, 'gameId': gameId},
          rawQueryParams: {'edit': editParam},
          initialChildren: children,
        );

  static const String name = 'ClubGameDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final queryParams = data.queryParams;
      final args = data.argsAs<ClubGameDetailRouteArgs>(
        orElse: () => ClubGameDetailRouteArgs(
          clubId: pathParams.optInt('clubId'),
          gameId: pathParams.optInt('gameId'),
          editParam: queryParams.optBool('edit'),
        ),
      );
      return ClubGameDetailPage(
        key: args.key,
        clubId: args.clubId,
        gameId: args.gameId,
        editParam: args.editParam,
      );
    },
  );
}

class ClubGameDetailRouteArgs {
  const ClubGameDetailRouteArgs({
    this.key,
    this.clubId,
    this.gameId,
    this.editParam,
  });

  final Key? key;

  final int? clubId;

  final int? gameId;

  final bool? editParam;

  @override
  String toString() {
    return 'ClubGameDetailRouteArgs{key: $key, clubId: $clubId, gameId: $gameId, editParam: $editParam}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ClubGameDetailRouteArgs) return false;
    return key == other.key &&
        clubId == other.clubId &&
        gameId == other.gameId &&
        editParam == other.editParam;
  }

  @override
  int get hashCode =>
      key.hashCode ^ clubId.hashCode ^ gameId.hashCode ^ editParam.hashCode;
}

/// generated route for
/// [ClubGamesPage]
class ClubGamesRoute extends PageRouteInfo<ClubGamesRouteArgs> {
  ClubGamesRoute({
    Key? key,
    required int clubId,
    String? dateStartParam,
    String? dateEndParam,
    List<PageRouteInfo>? children,
  }) : super(
          ClubGamesRoute.name,
          args: ClubGamesRouteArgs(
            key: key,
            clubId: clubId,
            dateStartParam: dateStartParam,
            dateEndParam: dateEndParam,
          ),
          rawPathParams: {'clubId': clubId},
          rawQueryParams: {
            'date-start': dateStartParam,
            'date-end': dateEndParam,
          },
          initialChildren: children,
        );

  static const String name = 'ClubGamesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final queryParams = data.queryParams;
      final args = data.argsAs<ClubGamesRouteArgs>(
        orElse: () => ClubGamesRouteArgs(
          clubId: pathParams.getInt('clubId'),
          dateStartParam: queryParams.optString('date-start'),
          dateEndParam: queryParams.optString('date-end'),
        ),
      );
      return ClubGamesPage(
        key: args.key,
        clubId: args.clubId,
        dateStartParam: args.dateStartParam,
        dateEndParam: args.dateEndParam,
      );
    },
  );
}

class ClubGamesRouteArgs {
  const ClubGamesRouteArgs({
    this.key,
    required this.clubId,
    this.dateStartParam,
    this.dateEndParam,
  });

  final Key? key;

  final int clubId;

  final String? dateStartParam;

  final String? dateEndParam;

  @override
  String toString() {
    return 'ClubGamesRouteArgs{key: $key, clubId: $clubId, dateStartParam: $dateStartParam, dateEndParam: $dateEndParam}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ClubGamesRouteArgs) return false;
    return key == other.key &&
        clubId == other.clubId &&
        dateStartParam == other.dateStartParam &&
        dateEndParam == other.dateEndParam;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      clubId.hashCode ^
      dateStartParam.hashCode ^
      dateEndParam.hashCode;
}

/// generated route for
/// [ClubPage]
class ClubRoute extends PageRouteInfo<ClubRouteArgs> {
  ClubRoute({
    Key? key,
    required int clubId,
    ClubModel? cachedModel,
    List<PageRouteInfo>? children,
  }) : super(
          ClubRoute.name,
          args: ClubRouteArgs(
            key: key,
            clubId: clubId,
            cachedModel: cachedModel,
          ),
          rawPathParams: {'clubId': clubId},
          initialChildren: children,
        );

  static const String name = 'ClubRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ClubRouteArgs>(
        orElse: () => ClubRouteArgs(clubId: pathParams.getInt('clubId')),
      );
      return ClubPage(
        key: args.key,
        clubId: args.clubId,
        cachedModel: args.cachedModel,
      );
    },
  );
}

class ClubRouteArgs {
  const ClubRouteArgs({this.key, required this.clubId, this.cachedModel});

  final Key? key;

  final int clubId;

  final ClubModel? cachedModel;

  @override
  String toString() {
    return 'ClubRouteArgs{key: $key, clubId: $clubId, cachedModel: $cachedModel}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ClubRouteArgs) return false;
    return key == other.key &&
        clubId == other.clubId &&
        cachedModel == other.cachedModel;
  }

  @override
  int get hashCode => key.hashCode ^ clubId.hashCode ^ cachedModel.hashCode;
}

/// generated route for
/// [ClubRatingPage]
class ClubRatingRoute extends PageRouteInfo<ClubRatingRouteArgs> {
  ClubRatingRoute({
    Key? key,
    int? clubId,
    String? dateStart,
    String? dateEnd,
    String? style,
    String? sort,
    int? gameFilter,
    int? customSortColumnIndex,
    List<PageRouteInfo>? children,
  }) : super(
          ClubRatingRoute.name,
          args: ClubRatingRouteArgs(
            key: key,
            clubId: clubId,
            dateStart: dateStart,
            dateEnd: dateEnd,
            style: style,
            sort: sort,
            gameFilter: gameFilter,
            customSortColumnIndex: customSortColumnIndex,
          ),
          rawPathParams: {'clubId': clubId},
          rawQueryParams: {
            'date-start': dateStart,
            'date-end': dateEnd,
            'style': style,
            'sort': sort,
            'game-filter': gameFilter,
            'custom-sort-column': customSortColumnIndex,
          },
          initialChildren: children,
        );

  static const String name = 'ClubRatingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final queryParams = data.queryParams;
      final args = data.argsAs<ClubRatingRouteArgs>(
        orElse: () => ClubRatingRouteArgs(
          clubId: pathParams.optInt('clubId'),
          dateStart: queryParams.optString('date-start'),
          dateEnd: queryParams.optString('date-end'),
          style: queryParams.optString('style'),
          sort: queryParams.optString('sort'),
          gameFilter: queryParams.optInt('game-filter'),
          customSortColumnIndex: queryParams.optInt('custom-sort-column'),
        ),
      );
      return ClubRatingPage(
        key: args.key,
        clubId: args.clubId,
        dateStart: args.dateStart,
        dateEnd: args.dateEnd,
        style: args.style,
        sort: args.sort,
        gameFilter: args.gameFilter,
        customSortColumnIndex: args.customSortColumnIndex,
      );
    },
  );
}

class ClubRatingRouteArgs {
  const ClubRatingRouteArgs({
    this.key,
    this.clubId,
    this.dateStart,
    this.dateEnd,
    this.style,
    this.sort,
    this.gameFilter,
    this.customSortColumnIndex,
  });

  final Key? key;

  final int? clubId;

  final String? dateStart;

  final String? dateEnd;

  final String? style;

  final String? sort;

  final int? gameFilter;

  final int? customSortColumnIndex;

  @override
  String toString() {
    return 'ClubRatingRouteArgs{key: $key, clubId: $clubId, dateStart: $dateStart, dateEnd: $dateEnd, style: $style, sort: $sort, gameFilter: $gameFilter, customSortColumnIndex: $customSortColumnIndex}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ClubRatingRouteArgs) return false;
    return key == other.key &&
        clubId == other.clubId &&
        dateStart == other.dateStart &&
        dateEnd == other.dateEnd &&
        style == other.style &&
        sort == other.sort &&
        gameFilter == other.gameFilter &&
        customSortColumnIndex == other.customSortColumnIndex;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      clubId.hashCode ^
      dateStart.hashCode ^
      dateEnd.hashCode ^
      style.hashCode ^
      sort.hashCode ^
      gameFilter.hashCode ^
      customSortColumnIndex.hashCode;
}

/// generated route for
/// [ClubsPage]
class ClubsRoute extends PageRouteInfo<void> {
  const ClubsRoute({List<PageRouteInfo>? children})
      : super(ClubsRoute.name, initialChildren: children);

  static const String name = 'ClubsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ClubsPage();
    },
  );
}

/// generated route for
/// [ContactsPage]
class ContactsRoute extends PageRouteInfo<void> {
  const ContactsRoute({List<PageRouteInfo>? children})
      : super(ContactsRoute.name, initialChildren: children);

  static const String name = 'ContactsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ContactsPage();
    },
  );
}

/// generated route for
/// [CustomColumnsEditorPage]
class CustomColumnsEditorRoute
    extends PageRouteInfo<CustomColumnsEditorRouteArgs> {
  CustomColumnsEditorRoute({
    Key? key,
    required int clubId,
    List<PageRouteInfo>? children,
  }) : super(
          CustomColumnsEditorRoute.name,
          args: CustomColumnsEditorRouteArgs(key: key, clubId: clubId),
          rawPathParams: {'clubId': clubId},
          initialChildren: children,
        );

  static const String name = 'CustomColumnsEditorRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<CustomColumnsEditorRouteArgs>(
        orElse: () =>
            CustomColumnsEditorRouteArgs(clubId: pathParams.getInt('clubId')),
      );
      return CustomColumnsEditorPage(key: args.key, clubId: args.clubId);
    },
  );
}

class CustomColumnsEditorRouteArgs {
  const CustomColumnsEditorRouteArgs({this.key, required this.clubId});

  final Key? key;

  final int clubId;

  @override
  String toString() {
    return 'CustomColumnsEditorRouteArgs{key: $key, clubId: $clubId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CustomColumnsEditorRouteArgs) return false;
    return key == other.key && clubId == other.clubId;
  }

  @override
  int get hashCode => key.hashCode ^ clubId.hashCode;
}

/// generated route for
/// [EditSeatingPage]
class EditSeatingRoute extends PageRouteInfo<EditSeatingRouteArgs> {
  EditSeatingRoute({
    Key? key,
    required int tournamentId,
    List<PageRouteInfo>? children,
  }) : super(
          EditSeatingRoute.name,
          args: EditSeatingRouteArgs(key: key, tournamentId: tournamentId),
          rawPathParams: {'id': tournamentId},
          initialChildren: children,
        );

  static const String name = 'EditSeatingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<EditSeatingRouteArgs>(
        orElse: () =>
            EditSeatingRouteArgs(tournamentId: pathParams.getInt('id')),
      );
      return EditSeatingPage(key: args.key, tournamentId: args.tournamentId);
    },
  );
}

class EditSeatingRouteArgs {
  const EditSeatingRouteArgs({this.key, required this.tournamentId});

  final Key? key;

  final int tournamentId;

  @override
  String toString() {
    return 'EditSeatingRouteArgs{key: $key, tournamentId: $tournamentId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EditSeatingRouteArgs) return false;
    return key == other.key && tournamentId == other.tournamentId;
  }

  @override
  int get hashCode => key.hashCode ^ tournamentId.hashCode;
}

/// generated route for
/// [FantasyPage]
class FantasyRoute extends PageRouteInfo<FantasyRouteArgs> {
  FantasyRoute({
    Key? key,
    required int tournamentId,
    List<PageRouteInfo>? children,
  }) : super(
          FantasyRoute.name,
          args: FantasyRouteArgs(key: key, tournamentId: tournamentId),
          rawPathParams: {'id': tournamentId},
          initialChildren: children,
        );

  static const String name = 'FantasyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<FantasyRouteArgs>(
        orElse: () => FantasyRouteArgs(tournamentId: pathParams.getInt('id')),
      );
      return FantasyPage(key: args.key, tournamentId: args.tournamentId);
    },
  );
}

class FantasyRouteArgs {
  const FantasyRouteArgs({this.key, required this.tournamentId});

  final Key? key;

  final int tournamentId;

  @override
  String toString() {
    return 'FantasyRouteArgs{key: $key, tournamentId: $tournamentId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FantasyRouteArgs) return false;
    return key == other.key && tournamentId == other.tournamentId;
  }

  @override
  int get hashCode => key.hashCode ^ tournamentId.hashCode;
}

/// generated route for
/// [ForgotPasswordPageBody]
class ForgotPasswordPageRoute extends PageRouteInfo<void> {
  const ForgotPasswordPageRoute({List<PageRouteInfo>? children})
      : super(ForgotPasswordPageRoute.name, initialChildren: children);

  static const String name = 'ForgotPasswordPageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ForgotPasswordPageBody();
    },
  );
}

/// generated route for
/// [InfoTableDescriptionPage]
class InfoTableDescriptionRoute
    extends PageRouteInfo<InfoTableDescriptionRouteArgs> {
  InfoTableDescriptionRoute({
    Key? key,
    required int tournamentId,
    List<PageRouteInfo>? children,
  }) : super(
          InfoTableDescriptionRoute.name,
          args: InfoTableDescriptionRouteArgs(
            key: key,
            tournamentId: tournamentId,
          ),
          rawPathParams: {'id': tournamentId},
          initialChildren: children,
        );

  static const String name = 'InfoTableDescriptionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<InfoTableDescriptionRouteArgs>(
        orElse: () => InfoTableDescriptionRouteArgs(
          tournamentId: pathParams.getInt('id'),
        ),
      );
      return InfoTableDescriptionPage(
        key: args.key,
        tournamentId: args.tournamentId,
      );
    },
  );
}

class InfoTableDescriptionRouteArgs {
  const InfoTableDescriptionRouteArgs({this.key, required this.tournamentId});

  final Key? key;

  final int tournamentId;

  @override
  String toString() {
    return 'InfoTableDescriptionRouteArgs{key: $key, tournamentId: $tournamentId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! InfoTableDescriptionRouteArgs) return false;
    return key == other.key && tournamentId == other.tournamentId;
  }

  @override
  int get hashCode => key.hashCode ^ tournamentId.hashCode;
}

/// generated route for
/// [LoginPageBody]
class LoginPageRoute extends PageRouteInfo<LoginPageRouteArgs> {
  LoginPageRoute({Key? key, String? nextPath, List<PageRouteInfo>? children})
      : super(
          LoginPageRoute.name,
          args: LoginPageRouteArgs(key: key, nextPath: nextPath),
          rawQueryParams: {'next': nextPath},
          initialChildren: children,
        );

  static const String name = 'LoginPageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<LoginPageRouteArgs>(
        orElse: () =>
            LoginPageRouteArgs(nextPath: queryParams.optString('next')),
      );
      return LoginPageBody(key: args.key, nextPath: args.nextPath);
    },
  );
}

class LoginPageRouteArgs {
  const LoginPageRouteArgs({this.key, this.nextPath});

  final Key? key;

  final String? nextPath;

  @override
  String toString() {
    return 'LoginPageRouteArgs{key: $key, nextPath: $nextPath}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LoginPageRouteArgs) return false;
    return key == other.key && nextPath == other.nextPath;
  }

  @override
  int get hashCode => key.hashCode ^ nextPath.hashCode;
}

/// generated route for
/// [NewClubGamePage]
class NewClubGameRoute extends PageRouteInfo<NewClubGameRouteArgs> {
  NewClubGameRoute({
    Key? key,
    int? clubId,
    DateTime? initDateTime,
    List<PageRouteInfo>? children,
  }) : super(
          NewClubGameRoute.name,
          args: NewClubGameRouteArgs(
            key: key,
            clubId: clubId,
            initDateTime: initDateTime,
          ),
          rawPathParams: {'clubId': clubId},
          initialChildren: children,
        );

  static const String name = 'NewClubGameRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<NewClubGameRouteArgs>(
        orElse: () => NewClubGameRouteArgs(clubId: pathParams.optInt('clubId')),
      );
      return NewClubGamePage(
        key: args.key,
        clubId: args.clubId,
        initDateTime: args.initDateTime,
      );
    },
  );
}

class NewClubGameRouteArgs {
  const NewClubGameRouteArgs({this.key, this.clubId, this.initDateTime});

  final Key? key;

  final int? clubId;

  final DateTime? initDateTime;

  @override
  String toString() {
    return 'NewClubGameRouteArgs{key: $key, clubId: $clubId, initDateTime: $initDateTime}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NewClubGameRouteArgs) return false;
    return key == other.key &&
        clubId == other.clubId &&
        initDateTime == other.initDateTime;
  }

  @override
  int get hashCode => key.hashCode ^ clubId.hashCode ^ initDateTime.hashCode;
}

/// generated route for
/// [PhotoThemesPage]
class PhotoThemesRoute extends PageRouteInfo<PhotoThemesRouteArgs> {
  PhotoThemesRoute({Key? key, int? tournamentId, List<PageRouteInfo>? children})
      : super(
          PhotoThemesRoute.name,
          args: PhotoThemesRouteArgs(key: key, tournamentId: tournamentId),
          initialChildren: children,
        );

  static const String name = 'PhotoThemesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PhotoThemesRouteArgs>(
        orElse: () => const PhotoThemesRouteArgs(),
      );
      return PhotoThemesPage(key: args.key, tournamentId: args.tournamentId);
    },
  );
}

class PhotoThemesRouteArgs {
  const PhotoThemesRouteArgs({this.key, this.tournamentId});

  final Key? key;

  final int? tournamentId;

  @override
  String toString() {
    return 'PhotoThemesRouteArgs{key: $key, tournamentId: $tournamentId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PhotoThemesRouteArgs) return false;
    return key == other.key && tournamentId == other.tournamentId;
  }

  @override
  int get hashCode => key.hashCode ^ tournamentId.hashCode;
}

/// generated route for
/// [PlayerStatsPage]
class PlayerStatsRoute extends PageRouteInfo<PlayerStatsRouteArgs> {
  PlayerStatsRoute({
    Key? key,
    required int playerId,
    List<PageRouteInfo>? children,
  }) : super(
          PlayerStatsRoute.name,
          args: PlayerStatsRouteArgs(key: key, playerId: playerId),
          rawPathParams: {'playerId': playerId},
          initialChildren: children,
        );

  static const String name = 'PlayerStatsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<PlayerStatsRouteArgs>(
        orElse: () =>
            PlayerStatsRouteArgs(playerId: pathParams.getInt('playerId')),
      );
      return PlayerStatsPage(key: args.key, playerId: args.playerId);
    },
  );
}

class PlayerStatsRouteArgs {
  const PlayerStatsRouteArgs({this.key, required this.playerId});

  final Key? key;

  final int playerId;

  @override
  String toString() {
    return 'PlayerStatsRouteArgs{key: $key, playerId: $playerId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PlayerStatsRouteArgs) return false;
    return key == other.key && playerId == other.playerId;
  }

  @override
  int get hashCode => key.hashCode ^ playerId.hashCode;
}

/// generated route for
/// [PlayersListBody]
class TournamentPlayersRoute extends PageRouteInfo<void> {
  const TournamentPlayersRoute({List<PageRouteInfo>? children})
      : super(TournamentPlayersRoute.name, initialChildren: children);

  static const String name = 'TournamentPlayersRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PlayersListBody();
    },
  );
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfilePage();
    },
  );
}

/// generated route for
/// [RailWrapperPage]
class RailWrapperRoute extends PageRouteInfo<void> {
  const RailWrapperRoute({List<PageRouteInfo>? children})
      : super(RailWrapperRoute.name, initialChildren: children);

  static const String name = 'RailWrapperRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RailWrapperPage();
    },
  );
}

/// generated route for
/// [RefereePage]
class RefereeRoute extends PageRouteInfo<RefereeRouteArgs> {
  RefereeRoute({
    Key? key,
    required int tournamentId,
    List<PageRouteInfo>? children,
  }) : super(
          RefereeRoute.name,
          args: RefereeRouteArgs(key: key, tournamentId: tournamentId),
          rawPathParams: {'id': tournamentId},
          initialChildren: children,
        );

  static const String name = 'RefereeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<RefereeRouteArgs>(
        orElse: () => RefereeRouteArgs(tournamentId: pathParams.getInt('id')),
      );
      return RefereePage(key: args.key, tournamentId: args.tournamentId);
    },
  );
}

class RefereeRouteArgs {
  const RefereeRouteArgs({this.key, required this.tournamentId});

  final Key? key;

  final int tournamentId;

  @override
  String toString() {
    return 'RefereeRouteArgs{key: $key, tournamentId: $tournamentId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RefereeRouteArgs) return false;
    return key == other.key && tournamentId == other.tournamentId;
  }

  @override
  int get hashCode => key.hashCode ^ tournamentId.hashCode;
}

/// generated route for
/// [ResetPasswordPageBody]
class ResetPasswordPageRoute extends PageRouteInfo<ResetPasswordPageRouteArgs> {
  ResetPasswordPageRoute({
    Key? key,
    String email = '',
    List<PageRouteInfo>? children,
  }) : super(
          ResetPasswordPageRoute.name,
          args: ResetPasswordPageRouteArgs(key: key, email: email),
          rawQueryParams: {'email': email},
          initialChildren: children,
        );

  static const String name = 'ResetPasswordPageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<ResetPasswordPageRouteArgs>(
        orElse: () => ResetPasswordPageRouteArgs(
          email: queryParams.getString('email', ''),
        ),
      );
      return ResetPasswordPageBody(key: args.key, email: args.email);
    },
  );
}

class ResetPasswordPageRouteArgs {
  const ResetPasswordPageRouteArgs({this.key, this.email = ''});

  final Key? key;

  final String email;

  @override
  String toString() {
    return 'ResetPasswordPageRouteArgs{key: $key, email: $email}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ResetPasswordPageRouteArgs) return false;
    return key == other.key && email == other.email;
  }

  @override
  int get hashCode => key.hashCode ^ email.hashCode;
}

/// generated route for
/// [SeatingPage]
class SeatingRoute extends PageRouteInfo<SeatingRouteArgs> {
  SeatingRoute({
    Key? key,
    required int tournamentId,
    List<PageRouteInfo>? children,
  }) : super(
          SeatingRoute.name,
          args: SeatingRouteArgs(key: key, tournamentId: tournamentId),
          rawPathParams: {'id': tournamentId},
          initialChildren: children,
        );

  static const String name = 'SeatingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<SeatingRouteArgs>(
        orElse: () => SeatingRouteArgs(tournamentId: pathParams.getInt('id')),
      );
      return SeatingPage(key: args.key, tournamentId: args.tournamentId);
    },
  );
}

class SeatingRouteArgs {
  const SeatingRouteArgs({this.key, required this.tournamentId});

  final Key? key;

  final int tournamentId;

  @override
  String toString() {
    return 'SeatingRouteArgs{key: $key, tournamentId: $tournamentId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SeatingRouteArgs) return false;
    return key == other.key && tournamentId == other.tournamentId;
  }

  @override
  int get hashCode => key.hashCode ^ tournamentId.hashCode;
}

/// generated route for
/// [SignUpPageBody]
class SignUpPageRoute extends PageRouteInfo<void> {
  const SignUpPageRoute({List<PageRouteInfo>? children})
      : super(SignUpPageRoute.name, initialChildren: children);

  static const String name = 'SignUpPageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignUpPageBody();
    },
  );
}

/// generated route for
/// [TempPage]
class TempRoute extends PageRouteInfo<void> {
  const TempRoute({List<PageRouteInfo>? children})
      : super(TempRoute.name, initialChildren: children);

  static const String name = 'TempRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TempPage();
    },
  );
}

/// generated route for
/// [TournamentGameDetailPage]
class TournamentGameDetailRoute
    extends PageRouteInfo<TournamentGameDetailRouteArgs> {
  TournamentGameDetailRoute({
    Key? key,
    int? tournamentId,
    int? gameId,
    bool? editParam,
    List<PageRouteInfo>? children,
  }) : super(
          TournamentGameDetailRoute.name,
          args: TournamentGameDetailRouteArgs(
            key: key,
            tournamentId: tournamentId,
            gameId: gameId,
            editParam: editParam,
          ),
          rawPathParams: {'id': tournamentId, 'gameId': gameId},
          rawQueryParams: {'edit': editParam},
          initialChildren: children,
        );

  static const String name = 'TournamentGameDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final queryParams = data.queryParams;
      final args = data.argsAs<TournamentGameDetailRouteArgs>(
        orElse: () => TournamentGameDetailRouteArgs(
          tournamentId: pathParams.optInt('id'),
          gameId: pathParams.optInt('gameId'),
          editParam: queryParams.optBool('edit'),
        ),
      );
      return TournamentGameDetailPage(
        key: args.key,
        tournamentId: args.tournamentId,
        gameId: args.gameId,
        editParam: args.editParam,
      );
    },
  );
}

class TournamentGameDetailRouteArgs {
  const TournamentGameDetailRouteArgs({
    this.key,
    this.tournamentId,
    this.gameId,
    this.editParam,
  });

  final Key? key;

  final int? tournamentId;

  final int? gameId;

  final bool? editParam;

  @override
  String toString() {
    return 'TournamentGameDetailRouteArgs{key: $key, tournamentId: $tournamentId, gameId: $gameId, editParam: $editParam}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TournamentGameDetailRouteArgs) return false;
    return key == other.key &&
        tournamentId == other.tournamentId &&
        gameId == other.gameId &&
        editParam == other.editParam;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      tournamentId.hashCode ^
      gameId.hashCode ^
      editParam.hashCode;
}

/// generated route for
/// [TournamentPage]
class TournamentRoute extends PageRouteInfo<TournamentRouteArgs> {
  TournamentRoute({
    Key? key,
    required int tournamentId,
    List<PageRouteInfo>? children,
  }) : super(
          TournamentRoute.name,
          args: TournamentRouteArgs(key: key, tournamentId: tournamentId),
          rawPathParams: {'id': tournamentId},
          initialChildren: children,
        );

  static const String name = 'TournamentRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TournamentRouteArgs>(
        orElse: () =>
            TournamentRouteArgs(tournamentId: pathParams.getInt('id')),
      );
      return TournamentPage(key: args.key, tournamentId: args.tournamentId);
    },
  );
}

class TournamentRouteArgs {
  const TournamentRouteArgs({this.key, required this.tournamentId});

  final Key? key;

  final int tournamentId;

  @override
  String toString() {
    return 'TournamentRouteArgs{key: $key, tournamentId: $tournamentId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TournamentRouteArgs) return false;
    return key == other.key && tournamentId == other.tournamentId;
  }

  @override
  int get hashCode => key.hashCode ^ tournamentId.hashCode;
}

/// generated route for
/// [TournamentRatingPage]
class TournamentRatingRoute extends PageRouteInfo<TournamentRatingRouteArgs> {
  TournamentRatingRoute({
    Key? key,
    int? tournamentId,
    String? style,
    String? sort,
    int? gameFilter,
    int? customSortColumnIndex,
    List<PageRouteInfo>? children,
  }) : super(
          TournamentRatingRoute.name,
          args: TournamentRatingRouteArgs(
            key: key,
            tournamentId: tournamentId,
            style: style,
            sort: sort,
            gameFilter: gameFilter,
            customSortColumnIndex: customSortColumnIndex,
          ),
          rawPathParams: {'id': tournamentId},
          rawQueryParams: {
            'style': style,
            'sort': sort,
            'game-filter': gameFilter,
            'custom-sort-column': customSortColumnIndex,
          },
          initialChildren: children,
        );

  static const String name = 'TournamentRatingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final queryParams = data.queryParams;
      final args = data.argsAs<TournamentRatingRouteArgs>(
        orElse: () => TournamentRatingRouteArgs(
          tournamentId: pathParams.optInt('id'),
          style: queryParams.optString('style'),
          sort: queryParams.optString('sort'),
          gameFilter: queryParams.optInt('game-filter'),
          customSortColumnIndex: queryParams.optInt('custom-sort-column'),
        ),
      );
      return TournamentRatingPage(
        key: args.key,
        tournamentId: args.tournamentId,
        style: args.style,
        sort: args.sort,
        gameFilter: args.gameFilter,
        customSortColumnIndex: args.customSortColumnIndex,
      );
    },
  );
}

class TournamentRatingRouteArgs {
  const TournamentRatingRouteArgs({
    this.key,
    this.tournamentId,
    this.style,
    this.sort,
    this.gameFilter,
    this.customSortColumnIndex,
  });

  final Key? key;

  final int? tournamentId;

  final String? style;

  final String? sort;

  final int? gameFilter;

  final int? customSortColumnIndex;

  @override
  String toString() {
    return 'TournamentRatingRouteArgs{key: $key, tournamentId: $tournamentId, style: $style, sort: $sort, gameFilter: $gameFilter, customSortColumnIndex: $customSortColumnIndex}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TournamentRatingRouteArgs) return false;
    return key == other.key &&
        tournamentId == other.tournamentId &&
        style == other.style &&
        sort == other.sort &&
        gameFilter == other.gameFilter &&
        customSortColumnIndex == other.customSortColumnIndex;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      tournamentId.hashCode ^
      style.hashCode ^
      sort.hashCode ^
      gameFilter.hashCode ^
      customSortColumnIndex.hashCode;
}

/// generated route for
/// [TournamentSettingsPage]
class TournamentSettingsRoute
    extends PageRouteInfo<TournamentSettingsRouteArgs> {
  TournamentSettingsRoute({
    Key? key,
    required int tournamentId,
    List<PageRouteInfo>? children,
  }) : super(
          TournamentSettingsRoute.name,
          args: TournamentSettingsRouteArgs(
            key: key,
            tournamentId: tournamentId,
          ),
          rawPathParams: {'id': tournamentId},
          initialChildren: children,
        );

  static const String name = 'TournamentSettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TournamentSettingsRouteArgs>(
        orElse: () =>
            TournamentSettingsRouteArgs(tournamentId: pathParams.getInt('id')),
      );
      return TournamentSettingsPage(
        key: args.key,
        tournamentId: args.tournamentId,
      );
    },
  );
}

class TournamentSettingsRouteArgs {
  const TournamentSettingsRouteArgs({this.key, required this.tournamentId});

  final Key? key;

  final int tournamentId;

  @override
  String toString() {
    return 'TournamentSettingsRouteArgs{key: $key, tournamentId: $tournamentId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TournamentSettingsRouteArgs) return false;
    return key == other.key && tournamentId == other.tournamentId;
  }

  @override
  int get hashCode => key.hashCode ^ tournamentId.hashCode;
}

/// generated route for
/// [TournamentsPage]
class TournamentsRoute extends PageRouteInfo<void> {
  const TournamentsRoute({List<PageRouteInfo>? children})
      : super(TournamentsRoute.name, initialChildren: children);

  static const String name = 'TournamentsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TournamentsPage();
    },
  );
}

/// generated route for
/// [TranslationControlPage]
class TranslationControlRoute
    extends PageRouteInfo<TranslationControlRouteArgs> {
  TranslationControlRoute({
    Key? key,
    int tournamentId = 0,
    int table = 0,
    String translationKey = '',
    List<PageRouteInfo>? children,
  }) : super(
          TranslationControlRoute.name,
          args: TranslationControlRouteArgs(
            key: key,
            tournamentId: tournamentId,
            table: table,
            translationKey: translationKey,
          ),
          rawQueryParams: {
            'tournamentId': tournamentId,
            'table': table,
            'key': translationKey,
          },
          initialChildren: children,
        );

  static const String name = 'TranslationControlRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<TranslationControlRouteArgs>(
        orElse: () => TranslationControlRouteArgs(
          tournamentId: queryParams.getInt('tournamentId', 0),
          table: queryParams.getInt('table', 0),
          translationKey: queryParams.getString('key', ''),
        ),
      );
      return TranslationControlPage(
        key: args.key,
        tournamentId: args.tournamentId,
        table: args.table,
        translationKey: args.translationKey,
      );
    },
  );
}

class TranslationControlRouteArgs {
  const TranslationControlRouteArgs({
    this.key,
    this.tournamentId = 0,
    this.table = 0,
    this.translationKey = '',
  });

  final Key? key;

  final int tournamentId;

  final int table;

  final String translationKey;

  @override
  String toString() {
    return 'TranslationControlRouteArgs{key: $key, tournamentId: $tournamentId, table: $table, translationKey: $translationKey}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TranslationControlRouteArgs) return false;
    return key == other.key &&
        tournamentId == other.tournamentId &&
        table == other.table &&
        translationKey == other.translationKey;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      tournamentId.hashCode ^
      table.hashCode ^
      translationKey.hashCode;
}

/// generated route for
/// [VerificationPageBody]
class VerificationPageRoute extends PageRouteInfo<VerificationPageRouteArgs> {
  VerificationPageRoute({
    Key? key,
    required int id,
    List<PageRouteInfo>? children,
  }) : super(
          VerificationPageRoute.name,
          args: VerificationPageRouteArgs(key: key, id: id),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'VerificationPageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<VerificationPageRouteArgs>(
        orElse: () => VerificationPageRouteArgs(id: pathParams.getInt('id')),
      );
      return VerificationPageBody(key: args.key, id: args.id);
    },
  );
}

class VerificationPageRouteArgs {
  const VerificationPageRouteArgs({this.key, required this.id});

  final Key? key;

  final int id;

  @override
  String toString() {
    return 'VerificationPageRouteArgs{key: $key, id: $id}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VerificationPageRouteArgs) return false;
    return key == other.key && id == other.id;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode;
}

/// generated route for
/// [WebViewScreen]
class WebViewRoute extends PageRouteInfo<WebViewRouteArgs> {
  WebViewRoute({
    Key? key,
    String title = '',
    String url = '',
    List<PageRouteInfo>? children,
  }) : super(
          WebViewRoute.name,
          args: WebViewRouteArgs(key: key, title: title, url: url),
          rawQueryParams: {'title': title, 'url': url},
          initialChildren: children,
        );

  static const String name = 'WebViewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<WebViewRouteArgs>(
        orElse: () => WebViewRouteArgs(
          title: queryParams.getString('title', ''),
          url: queryParams.getString('url', ''),
        ),
      );
      return WebViewScreen(key: args.key, title: args.title, url: args.url);
    },
  );
}

class WebViewRouteArgs {
  const WebViewRouteArgs({this.key, this.title = '', this.url = ''});

  final Key? key;

  final String title;

  final String url;

  @override
  String toString() {
    return 'WebViewRouteArgs{key: $key, title: $title, url: $url}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WebViewRouteArgs) return false;
    return key == other.key && title == other.title && url == other.url;
  }

  @override
  int get hashCode => key.hashCode ^ title.hashCode ^ url.hashCode;
}
