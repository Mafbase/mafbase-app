import 'package:flutter/material.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';
import 'package:seating_generator_web/common/widgets/club_avatar.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';
import 'package:seating_generator_web/ui/main/club_page/widgets/club_subscription_badge.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ClubHeroCard extends StatelessWidget {
  final ClubModel clubModel;
  final bool isOwner;
  final VoidCallback? onEditPhoto;

  const ClubHeroCard({
    super.key,
    required this.clubModel,
    required this.isOwner,
    this.onEditPhoto,
  });

  @override
  Widget build(BuildContext context) {
    return context.isMobile ? _buildMobile(context) : _buildDesktop(context);
  }

  Widget _buildDesktop(BuildContext context) {
    final theme = context.theme;
    return Container(
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
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
      child: Row(
        children: [
          _buildAvatar(context, size: 100, borderRadius: 16, overlaySize: 32),
          const SizedBox(width: 24),
          Expanded(child: _buildInfo(context, titleSize: 28)),
        ],
      ),
    );
  }

  Widget _buildMobile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildAvatar(context, size: 72, borderRadius: 12, overlaySize: 26),
          const SizedBox(width: 16),
          Expanded(child: _buildInfo(context, titleSize: 22)),
        ],
      ),
    );
  }

  Widget _buildAvatar(
    BuildContext context, {
    required double size,
    required double borderRadius,
    required double overlaySize,
  }) {
    final theme = context.theme;
    return Stack(
      children: [
        ClubAvatar(
          clubModel: clubModel,
          size: size,
          borderRadius: BorderRadius.circular(borderRadius),
          placeholderColor: theme.darkGreyColor,
        ),
        if (isOwner && onEditPhoto != null)
          Positioned(
            right: 0,
            bottom: 0,
            child: Material(
              color: theme.darkBlueColor,
              borderRadius: BorderRadius.circular(overlaySize / 2),
              child: InkWell(
                borderRadius: BorderRadius.circular(overlaySize / 2),
                onTap: onEditPhoto,
                child: SizedBox(
                  width: overlaySize,
                  height: overlaySize,
                  child: Icon(
                    Icons.photo_camera_outlined,
                    size: overlaySize * 0.5,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInfo(BuildContext context, {required double titleSize}) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          clubModel.name,
          style: TextStyle(
            fontSize: titleSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (clubModel.city != null) ...[
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 14, color: theme.hintColor),
              const SizedBox(width: 4),
              Text(
                clubModel.city!,
                style: TextStyle(fontSize: 14, color: theme.hintColor),
              ),
            ],
          ),
        ],
        if (clubModel.groupLink != null) ...[
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () => _openLink(clubModel.groupLink!),
            child: Row(
              children: [
                Icon(Icons.link, size: 14, color: theme.darkGreyColor),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    clubModel.groupLink!,
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.darkGreyColor,
                      decoration: TextDecoration.underline,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
        if (isOwner && clubModel.billedFor != null) ...[
          const SizedBox(height: 10),
          ClubSubscriptionBadge(billedFor: clubModel.billedFor!),
        ],
      ],
    );
  }

  void _openLink(String url) {
    final uri = Uri.tryParse(url.startsWith('http') ? url : 'https://$url');
    if (uri != null) {
      launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
