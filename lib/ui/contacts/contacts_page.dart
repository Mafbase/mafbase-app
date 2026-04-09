import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: context.backOrGoToDefault(),),
        title: Text(context.locale.contacts),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.background2,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.borderColor),
              boxShadow: [
                BoxShadow(
                  color: theme.cardShadowColor,
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: DefaultTextStyle(
              style: theme.defaultTextStyle,
              child: SelectionArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildClickableRow(
                      icon: Icons.phone,
                      text: '+79528828343',
                      url: 'tel:+79528828343',
                      theme: theme,
                    ),
                    const SizedBox(height: 16),
                    _buildRow(
                      icon: Icons.person,
                      text: 'Анисов Сергей Владимирович',
                      theme: theme,
                    ),
                    const SizedBox(height: 16),
                    _buildRow(
                      icon: Icons.perm_contact_cal_outlined,
                      text: 'ИНН: 701724290760',
                      theme: theme,
                    ),
                    const SizedBox(height: 16),
                    _buildClickableRow(
                      icon: Icons.telegram,
                      text: '@strelas70',
                      url: 'https://t.me/strelas70',
                      theme: theme,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow({
    required IconData icon,
    required String text,
    required MyTheme theme,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 24, color: theme.btnColor2),
        const SizedBox(width: 8),
        Flexible(child: Text(text)),
      ],
    );
  }

  Widget _buildClickableRow({
    required IconData icon,
    required String text,
    required String url,
    required MyTheme theme,
  }) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      mouseCursor: SystemMouseCursors.click,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24, color: theme.btnColor2),
          const SizedBox(width: 8),
          Flexible(child: Text(text)),
        ],
      ),
    );
  }
}
