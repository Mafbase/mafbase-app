import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/ui/main/profile_page/widgets/player_avatar_widget.dart';
import 'package:seating_generator_web/utils.dart';

class ProfilePlayerCard extends StatelessWidget {
  final PlayerModel? player;
  final bool isMobile;
  final VoidCallback onChangePlayer;
  final VoidCallback onLinkPlayer;
  final VoidCallback? onEditPhoto;
  final bool isUploadingPhoto;

  const ProfilePlayerCard({
    super.key,
    required this.player,
    required this.isMobile,
    required this.onChangePlayer,
    required this.onLinkPlayer,
    this.onEditPhoto,
    this.isUploadingPhoto = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final locale = context.locale;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.background2,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.cardShadowColor,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Row(
              children: [
                Icon(Icons.person_outline, size: 18, color: theme.textColor),
                const SizedBox(width: 8),
                Text(
                  locale.profilePlayerCardTitle,
                  style: theme.defaultTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          if (player != null)
            _buildLinkedPlayer(context, player!, theme, locale)
          else
            _buildNotLinked(context, theme, locale),
        ],
      ),
    );
  }

  Widget _buildLinkedPlayer(
    BuildContext context,
    PlayerModel player,
    MyTheme theme,
    dynamic locale,
  ) {
    final changeButton = OutlinedButton(
      onPressed: onChangePlayer,
      style: OutlinedButton.styleFrom(
        foregroundColor: theme.textColor,
        side: BorderSide(color: theme.textColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: const Size(0, 36),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: Text(
        isMobile ? locale.profilePlayerChangeButtonMobile : locale.profilePlayerChangeButtonDesktop,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      ),
    );

    final avatar = _EditableAvatar(
      player: player,
      size: 52,
      isUploading: isUploadingPhoto,
      onEditPhoto: onEditPhoto,
    );

    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                avatar,
                const SizedBox(width: 12),
                Expanded(child: _playerInfo(player, theme, locale)),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(width: double.infinity, child: changeButton),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          avatar,
          const SizedBox(width: 12),
          Expanded(child: _playerInfo(player, theme, locale)),
          const SizedBox(width: 12),
          changeButton,
        ],
      ),
    );
  }

  Widget _playerInfo(PlayerModel player, MyTheme theme, dynamic locale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          player.nickname,
          style: theme.defaultTextStyle.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        if (player.fsmNickaname != null) ...[
          const SizedBox(height: 2),
          Text(
            locale.profileFsmNickname(player.fsmNickaname!),
            style: theme.defaultTextStyle.copyWith(
              fontSize: 12,
              color: theme.darkGreyColor,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildNotLinked(
    BuildContext context,
    MyTheme theme,
    dynamic locale,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const PlayerAvatarWidget(player: null, size: 52),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              locale.profilePlayerNotLinked,
              style: theme.defaultTextStyle.copyWith(
                color: theme.darkGreyColor,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: onLinkPlayer,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.darkBlueColor,
              foregroundColor: Colors.white,
              elevation: 0,
              minimumSize: const Size(0, 36),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              locale.profilePlayerLinkButton,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _EditableAvatar extends StatelessWidget {
  final PlayerModel player;
  final double size;
  final bool isUploading;
  final VoidCallback? onEditPhoto;

  const _EditableAvatar({
    required this.player,
    required this.size,
    required this.isUploading,
    this.onEditPhoto,
  });

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final badgeSize = size * 0.54;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          PlayerAvatarWidget(player: player, size: size),
          if (isUploading)
            Positioned.fill(
              child: ClipOval(
                child: ColoredBox(
                  color: theme.avatarUploadOverlayColor,
                  child: Center(
                    child: SizedBox(
                      width: size * 0.4,
                      height: size * 0.4,
                      child: CircularProgressIndicator(
                        color: theme.btnTextColor,
                        strokeWidth: 2.5,
                      ),
                    ),
                  ),
                ),
              ),
            )
          else if (onEditPhoto != null)
            Positioned(
              right: -2,
              bottom: -2,
              child: InkWell(
                onTap: onEditPhoto,
                child: Container(
                  width: badgeSize,
                  height: badgeSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.darkBlueColor,
                    border: Border.all(color: theme.background2, width: 2),
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: theme.btnTextColor,
                    size: badgeSize * 0.55,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
