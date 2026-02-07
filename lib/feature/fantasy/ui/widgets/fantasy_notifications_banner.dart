import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/domain/services/notification_permission_service.dart';
import 'package:seating_generator_web/utils.dart';

class FantasyNotificationsBanner extends StatefulWidget {
  const FantasyNotificationsBanner({super.key});

  @override
  State<FantasyNotificationsBanner> createState() => _FantasyNotificationsBannerState();
}

class _FantasyNotificationsBannerState extends State<FantasyNotificationsBanner> {
  late final NotificationPermissionService _notificationPermissionService;

  @override
  void initState() {
    super.initState();
    _notificationPermissionService = getIt<NotificationPermissionService>();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<PermissionStatus>(
        stream: _notificationPermissionService.notificationStatusStream,
        builder: (context, snapshot) {
          if (kIsWeb) {
            return const SizedBox.shrink();
          }

          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          }

          final status = snapshot.data!;
          if (status.isGranted) {
            return const SizedBox.shrink();
          }

          return Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.1),
              border: Border.all(color: Colors.orange),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.notifications_off,
                      color: Colors.orange,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        context.locale.fantasyNotificationsDisabled,
                        style: MyTheme.of(context).defaultTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange.shade700,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  context.locale.fantasyNotificationsDisabledDescription,
                  style: MyTheme.of(context).defaultTextStyle.copyWith(
                        color: Colors.orange.shade700,
                      ),
                ),
                const SizedBox(height: 8),
                CustomButton(
                  text: context.locale.fantasyEnableNotifications,
                  onTap: () async {
                    final result = await _notificationPermissionService.requestNotificationPermission();
                    if (context.mounted && result.isGranted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            context.locale.fantasyNotificationsEnabled,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      );
}
