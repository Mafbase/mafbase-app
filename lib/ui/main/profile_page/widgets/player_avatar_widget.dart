import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';

class PlayerAvatarWidget extends StatelessWidget {
  final PlayerModel? player;
  final double size;

  const PlayerAvatarWidget({
    super.key,
    required this.player,
    this.size = 52,
  });

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);

    if (player == null) {
      return _Circle(
        size: size,
        color: theme.greyColor,
        child: Icon(Icons.person, color: Colors.white, size: size * 0.5),
      );
    }

    final imageUrl = player!.imageUrl;
    if (imageUrl != null) {
      return Container(
        decoration: const BoxDecoration(shape: BoxShape.circle),
        clipBehavior: Clip.hardEdge,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          height: size,
          width: size,
          fit: BoxFit.cover,
          placeholder: (_, __) => _InitialsPlaceholder(
            nickname: player!.nickname,
            size: size,
            color: theme.darkBlueColor,
          ),
          errorWidget: (_, __, ___) => _InitialsPlaceholder(
            nickname: player!.nickname,
            size: size,
            color: theme.darkBlueColor,
          ),
        ),
      );
    }

    return _InitialsPlaceholder(
      nickname: player!.nickname,
      size: size,
      color: theme.darkBlueColor,
    );
  }
}

class _Circle extends StatelessWidget {
  final double size;
  final Color color;
  final Widget child;

  const _Circle({
    required this.size,
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        height: size,
        width: size,
        color: color,
        child: Center(child: child),
      ),
    );
  }
}

class _InitialsPlaceholder extends StatelessWidget {
  final String nickname;
  final double size;
  final Color color;

  const _InitialsPlaceholder({
    required this.nickname,
    required this.size,
    required this.color,
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
    return _Circle(
      size: size,
      color: color,
      child: Text(
        _initials,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: size * 0.38,
        ),
      ),
    );
  }
}
