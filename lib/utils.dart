import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';

extension BuildContextLocaleExt on BuildContext {
  AppLocalizations get locale => AppLocalizations.of(this)!;

  MyTheme get theme => MyTheme.of(this);
}

final dateFormatForRequests = DateFormat("yyyy-MM-dd");
String get sentryUrl => String.fromCharCodes([
      104,
      116,
      116,
      112,
      115,
      58,
      47,
      47,
      57,
      100,
      53,
      101,
      53,
      54,
      51,
      98,
      50,
      99,
      102,
      57,
      52,
      100,
      49,
      48,
      98,
      54,
      52,
      98,
      102,
      102,
      52,
      55,
      48,
      56,
      97,
      49,
      54,
      57,
      100,
      99,
      64,
      111,
      52,
      53,
      48,
      51,
      57,
      48,
      55,
      53,
      48,
      51,
      53,
      55,
      48,
      57,
      52,
      52,
      46,
      105,
      110,
      103,
      101,
      115,
      116,
      46,
      115,
      101,
      110,
      116,
      114,
      121,
      46,
      105,
      111,
      47,
      52,
      53,
      48,
      51,
      57,
      48,
      55,
      53,
      48,
      52,
      54,
      56,
      53,
      48,
      53,
      54
    ]);

class Pair<F, S> {
  final F first;
  final S second;

  Pair(this.first, this.second);

  @override
  bool operator ==(Object other) {
    return other is Pair<F, S> &&
        other.first == first &&
        other.second == second;
  }

  @override
  int get hashCode => first.hashCode ^ second.hashCode;
}
