import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/feature/streams/ui/widgets/streams_guide_step.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/link_actions.dart';

const mafbaseAppStoreUrl = 'https://apps.apple.com/ru/app/mafbase/id6593686225';
const mafbaseRuStoreUrl = 'https://www.rustore.ru/catalog/app/ru.mafbase.app';

/// Ссылка оператора, открытая в браузере: трансляцию запускает только приложение на телефоне.
class BroadcastAppRequiredView extends StatelessWidget {
  final String link;

  const BroadcastAppRequiredView({
    super.key,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final locale = context.locale;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.smartphone, size: 64, color: theme.greyColor),
            const SizedBox(height: 16),
            Text(
              locale.broadcastAppRequiredTitle,
              style: theme.headerTextStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            StreamsGuideStep(number: 1, text: locale.broadcastAppRequiredInstall),
            StreamsGuideStep(number: 2, text: locale.broadcastAppRequiredOpenLink),
            const SizedBox(height: 24),
            CustomButton(
              text: locale.broadcastAppStore,
              onTap: () => openLinkInNewTab(mafbaseAppStoreUrl),
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: locale.broadcastRuStore,
              onTap: () => openLinkInNewTab(mafbaseRuStoreUrl),
            ),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: () => copyLink(context, link, message: locale.broadcastLinkCopied),
              icon: const Icon(Icons.copy),
              label: Text(locale.broadcastCopyLink),
            ),
            const SizedBox(height: 16),
            Text(
              locale.broadcastMessengerBrowserTip,
              style: theme.defaultTextStyle.copyWith(color: theme.darkGreyColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
