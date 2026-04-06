import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seating_generator_web/app/assets.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pbenum.dart';

class TranslationControlPlayerCard extends StatelessWidget {
  final int index;
  final String nickname;
  final String imageUrl;
  final PlayerRole role;
  final PlayerStatus status;
  final ValueChanged<PlayerRole> onRoleChanged;
  final ValueChanged<PlayerStatus> onStatusChanged;

  const TranslationControlPlayerCard({
    super.key,
    required this.index,
    required this.nickname,
    required this.imageUrl,
    required this.role,
    required this.status,
    required this.onRoleChanged,
    required this.onStatusChanged,
  });

  bool get _isDead =>
      status == PlayerStatus.killed ||
      status == PlayerStatus.deleted ||
      status == PlayerStatus.voted;

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: _isDead ? theme.background1 : theme.background2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.borderColor.withValues(alpha: _isDead ? 0.5 : 1.0),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.cardShadowColor,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Opacity(
        opacity: _isDead ? 0.55 : 1.0,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              _PlayerNumber(index: index, theme: theme),
              const SizedBox(width: 8),
              _PlayerAvatar(imageUrl: imageUrl, nickname: nickname, theme: theme),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  nickname,
                  overflow: TextOverflow.ellipsis,
                  style: theme.defaultTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _StatusPicker(
                status: status,
                onChanged: onStatusChanged,
                theme: theme,
              ),
              Container(
                width: 1,
                height: 28,
                color: theme.borderColor,
                margin: const EdgeInsets.symmetric(horizontal: 4),
              ),
              _RolePicker(
                role: role,
                onChanged: onRoleChanged,
                theme: theme,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlayerNumber extends StatelessWidget {
  final int index;
  final MyTheme theme;

  const _PlayerNumber({required this.index, required this.theme});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      child: Text(
        '${index + 1}',
        textAlign: TextAlign.center,
        style: theme.defaultTextStyle.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: theme.darkGreyColor,
        ),
      ),
    );
  }
}

class _PlayerAvatar extends StatelessWidget {
  final String imageUrl;
  final String nickname;
  final MyTheme theme;

  const _PlayerAvatar({
    required this.imageUrl,
    required this.nickname,
    required this.theme,
  });

  String get _initials {
    final parts = nickname.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return nickname.isNotEmpty ? nickname[0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isNotEmpty) {
      return ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          height: 40,
          width: 40,
          fit: BoxFit.cover,
          placeholder: (_, __) => _AvatarPlaceholder(initials: _initials, theme: theme),
          errorWidget: (_, __, ___) => _AvatarPlaceholder(initials: _initials, theme: theme),
        ),
      );
    }
    return _AvatarPlaceholder(initials: _initials, theme: theme);
  }
}

class _AvatarPlaceholder extends StatelessWidget {
  final String initials;
  final MyTheme theme;

  const _AvatarPlaceholder({required this.initials, required this.theme});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: 40,
        height: 40,
        color: theme.darkBlueColor,
        child: Center(
          child: Text(
            initials,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusPicker extends StatelessWidget {
  final PlayerStatus status;
  final ValueChanged<PlayerStatus> onChanged;
  final MyTheme theme;

  const _StatusPicker({
    required this.status,
    required this.onChanged,
    required this.theme,
  });

  static const _duration = Duration(milliseconds: 150);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _StatusIcon(
            asset: AppAssets.deletedStatus,
            isActive: status == PlayerStatus.deleted,
            activeColor: theme.btnColor2,
            duration: _duration,
            onTap: () => onChanged(
              status == PlayerStatus.deleted ? PlayerStatus.alive : PlayerStatus.deleted,
            ),
          ),
          _StatusIcon(
            asset: AppAssets.killedStatus,
            isActive: status == PlayerStatus.killed,
            activeColor: theme.btnColor2,
            duration: _duration,
            onTap: () => onChanged(
              status == PlayerStatus.killed ? PlayerStatus.alive : PlayerStatus.killed,
            ),
          ),
          _StatusIcon(
            asset: AppAssets.votedStatus,
            isActive: status == PlayerStatus.voted,
            activeColor: theme.btnColor2,
            duration: _duration,
            onTap: () => onChanged(
              status == PlayerStatus.voted ? PlayerStatus.alive : PlayerStatus.voted,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusIcon extends StatelessWidget {
  final String asset;
  final bool isActive;
  final Color activeColor;
  final Duration duration;
  final VoidCallback onTap;

  const _StatusIcon({
    required this.asset,
    required this.isActive,
    required this.activeColor,
    required this.duration,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedOpacity(
              opacity: isActive ? 1.0 : 0.25,
              duration: duration,
              child: SvgPicture.asset(asset, height: 34),
            ),
            const SizedBox(height: 3),
            isActive
                ? Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: activeColor,
                    ),
                  )
                : const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}

class _RolePicker extends StatelessWidget {
  final PlayerRole role;
  final ValueChanged<PlayerRole> onChanged;
  final MyTheme theme;

  const _RolePicker({
    required this.role,
    required this.onChanged,
    required this.theme,
  });

  static const _duration = Duration(milliseconds: 150);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 168,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _RoleIcon(
            asset: AppAssets.mafiaAsset(),
            isActive: role == PlayerRole.maf,
            activeColor: theme.positiveColor,
            duration: _duration,
            onTap: () => onChanged(PlayerRole.maf),
          ),
          _RoleIcon(
            asset: AppAssets.donAsset(),
            isActive: role == PlayerRole.don,
            activeColor: theme.positiveColor,
            duration: _duration,
            onTap: () => onChanged(PlayerRole.don),
          ),
          _RoleIcon(
            asset: AppAssets.sheriffAsset(),
            isActive: role == PlayerRole.sheriff,
            activeColor: theme.positiveColor,
            duration: _duration,
            onTap: () => onChanged(PlayerRole.sheriff),
          ),
          _RoleIcon(
            asset: AppAssets.citizenAsset(),
            isActive: role == PlayerRole.citizen,
            activeColor: theme.positiveColor,
            duration: _duration,
            onTap: () => onChanged(PlayerRole.citizen),
          ),
        ],
      ),
    );
  }
}

class _RoleIcon extends StatelessWidget {
  final String asset;
  final bool isActive;
  final Color activeColor;
  final Duration duration;
  final VoidCallback onTap;

  const _RoleIcon({
    required this.asset,
    required this.isActive,
    required this.activeColor,
    required this.duration,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedOpacity(
              opacity: isActive ? 1.0 : 0.22,
              duration: duration,
              child: Image.asset(asset, height: 34),
            ),
            const SizedBox(height: 3),
            isActive
                ? Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: activeColor,
                    ),
                  )
                : const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
