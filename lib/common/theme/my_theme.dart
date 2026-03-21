import 'package:flutter/material.dart';

class MyTheme extends ThemeExtension<MyTheme> {
  const MyTheme({
    required this.background1,
    required this.background2,
    required this.btnColor1,
    required this.btnColor2,
    required this.btnTextColor,
    required this.textColor,
    required this.borderColor,
    required this.hintColor,
    required this.defaultTextStyle,
    required this.hintTextStyle,
    required this.fieldTextStyle,
    required this.btnTextStyle,
    required this.textBtnTextStyle,
    required this.headerTextStyle,
    required this.darkBlueColor,
    required this.redColor,
    required this.greyColor,
    required this.darkGreyColor,
    required this.redForCard,
    required this.greenForCard,
    required this.blueForCard,
    required this.buttonDisabledColor,
    required this.btnRedColor,
    required this.btnRedColor1,
    required this.diedPositiveColor,
    required this.positiveColor,
    required this.negativeColor,
    required this.diedColor,
    required this.sidebarDividerColor,
    required this.sidebarSectionTitleColor,
    required this.sidebarInactiveTextColor,
    required this.sidebarActiveItemBgColor,
    required this.cardShadowColor,
    required this.successColor,
    required this.hoverColor,
    required this.statusActiveColor,
    required this.statusActiveBgColor,
    required this.statusBillingColor,
    required this.statusBillingBgColor,
    required this.statusEndedColor,
  });

  final Color background1;
  final Color background2;
  final Color btnColor1;
  final Color btnColor2;
  final Color btnTextColor;
  final Color textColor;
  final Color borderColor;
  final Color hintColor;
  final TextStyle defaultTextStyle;
  final TextStyle hintTextStyle;
  final TextStyle fieldTextStyle;
  final TextStyle btnTextStyle;
  final TextStyle textBtnTextStyle;
  final TextStyle headerTextStyle;
  final Color darkBlueColor;
  final Color redColor;
  final Color greyColor;
  final Color darkGreyColor;
  final Color redForCard;
  final Color greenForCard;
  final Color blueForCard;
  final Color buttonDisabledColor;
  final Color btnRedColor;
  final Color btnRedColor1;
  final Color diedPositiveColor;
  final Color positiveColor;
  final Color negativeColor;
  final Color diedColor;
  final Color sidebarDividerColor;
  final Color sidebarSectionTitleColor;
  final Color sidebarInactiveTextColor;
  final Color sidebarActiveItemBgColor;
  final Color cardShadowColor;
  final Color successColor;
  final Color hoverColor;
  final Color statusActiveColor;
  final Color statusActiveBgColor;
  final Color statusBillingColor;
  final Color statusBillingBgColor;
  final Color statusEndedColor;

  static MyTheme of(BuildContext context) => Theme.of(context).extension<MyTheme>()!;

  factory MyTheme.light({required bool isMobile}) {
    const darkBlueColor = Color(0xFF1A2D42);
    const redColor = Color(0xFFDF5650);
    const greyColor = Color(0xFFCBCED3);
    const darkGreyColor = Color(0xFF475264);
    const blueForCard = Color(0xCC182D42);
    const background1 = Color(0xFFF5F5F5);
    const base = TextStyle(color: Colors.black);

    final defaultTextStyle = base.copyWith(
      fontSize: isMobile ? 12.0 : 16.0,
      fontWeight: FontWeight.w400,
    );

    return MyTheme(
      background1: background1,
      background2: Colors.white,
      btnColor1: darkGreyColor.withValues(alpha: 0.64),
      btnColor2: const Color(0xFF4E6B9B),
      btnTextColor: Colors.white,
      textColor: Colors.black,
      borderColor: const Color(0x403B1C2B),
      hintColor: const Color(0xFFB4B9BF),
      defaultTextStyle: defaultTextStyle,
      hintTextStyle: base.copyWith(
        fontSize: isMobile ? 10.0 : 12.0,
        color: greyColor,
      ),
      fieldTextStyle: defaultTextStyle,
      btnTextStyle: base.copyWith(
        fontSize: isMobile ? 15.0 : 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      textBtnTextStyle: base.copyWith(
        color: blueForCard,
        fontSize: isMobile ? 18.0 : 24.0,
      ),
      headerTextStyle: base.copyWith(
        fontSize: isMobile ? 22.0 : 28.0,
        fontWeight: FontWeight.w600,
        color: darkBlueColor,
      ),
      darkBlueColor: darkBlueColor,
      redColor: redColor,
      greyColor: greyColor,
      darkGreyColor: darkGreyColor,
      redForCard: const Color(0xCC81332C),
      greenForCard: const Color(0xCC285927),
      blueForCard: blueForCard,
      buttonDisabledColor: const Color(0xFFB4B9BF),
      btnRedColor: redColor,
      btnRedColor1: redColor.withValues(alpha: 0.7),
      diedPositiveColor: const Color(0xFF47644A),
      positiveColor: const Color(0xFFC8B75E),
      negativeColor: redColor,
      diedColor: darkGreyColor,
      sidebarDividerColor: Colors.white.withValues(alpha: 0.08),
      sidebarSectionTitleColor: Colors.white.withValues(alpha: 0.4),
      sidebarInactiveTextColor: Colors.white.withValues(alpha: 0.6),
      sidebarActiveItemBgColor: Colors.white.withValues(alpha: 0.12),
      cardShadowColor: const Color(0x141A2D42),
      successColor: const Color(0xFF4CAF50),
      hoverColor: const Color(0xFFF0F0F0),
      statusActiveColor: const Color(0xFF3D9E76),
      statusActiveBgColor: const Color(0xFF66CCA7),
      statusBillingColor: const Color(0xFFC4A600),
      statusBillingBgColor: const Color(0xFFFFE600),
      statusEndedColor: const Color(0xFF8E9199),
    );
  }

  factory MyTheme.dark({required bool isMobile}) {
    const darkBlueColor = Color(0xFF0A1620);
    const background1 = Color(0xFF0F1D2E);
    const background2 = Color(0xFF152232);
    const textColor = Color(0xFFE8EAED);
    const darkGreyColor = Color(0xFF8A9AB5);
    const greyColor = Color(0xFF4A5568);
    const redColor = Color(0xFFDF5650);
    const blueForCard = Color(0xCC4A7A9B);
    const base = TextStyle(color: textColor);

    final defaultTextStyle = base.copyWith(
      fontSize: isMobile ? 12.0 : 16.0,
      fontWeight: FontWeight.w400,
    );

    return MyTheme(
      background1: background1,
      background2: background2,
      btnColor1: darkGreyColor.withValues(alpha: 0.64),
      btnColor2: const Color(0xFF6B8FCC),
      btnTextColor: Colors.white,
      textColor: textColor,
      borderColor: Colors.white.withValues(alpha: 0.12),
      hintColor: const Color(0xFF7A8A9E),
      defaultTextStyle: defaultTextStyle,
      hintTextStyle: base.copyWith(fontSize: isMobile ? 10.0 : 12.0, color: greyColor),
      fieldTextStyle: defaultTextStyle,
      btnTextStyle: base.copyWith(fontSize: isMobile ? 15.0 : 18.0, fontWeight: FontWeight.w600),
      textBtnTextStyle: base.copyWith(color: blueForCard, fontSize: isMobile ? 18.0 : 24.0),
      headerTextStyle: base.copyWith(
        fontSize: isMobile ? 22.0 : 28.0,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      darkBlueColor: darkBlueColor,
      redColor: redColor,
      greyColor: greyColor,
      darkGreyColor: darkGreyColor,
      redForCard: const Color(0xCC81332C),
      greenForCard: const Color(0xCC285927),
      blueForCard: blueForCard,
      buttonDisabledColor: const Color(0xFF4A5568),
      btnRedColor: redColor,
      btnRedColor1: redColor.withValues(alpha: 0.7),
      diedPositiveColor: const Color(0xFF47644A),
      positiveColor: const Color(0xFFC8B75E),
      negativeColor: redColor,
      diedColor: darkGreyColor,
      sidebarDividerColor: Colors.white.withValues(alpha: 0.08),
      sidebarSectionTitleColor: Colors.white.withValues(alpha: 0.4),
      sidebarInactiveTextColor: Colors.white.withValues(alpha: 0.6),
      sidebarActiveItemBgColor: Colors.white.withValues(alpha: 0.12),
      cardShadowColor: Colors.black.withValues(alpha: 0.3),
      successColor: const Color(0xFF4CAF50),
      hoverColor: const Color(0xFF1E3045),
      statusActiveColor: const Color(0xFF3D9E76),
      statusActiveBgColor: const Color(0xFF66CCA7),
      statusBillingColor: const Color(0xFFC4A600),
      statusBillingBgColor: const Color(0xFFFFE600),
      statusEndedColor: const Color(0xFF8E9199),
    );
  }

  @override
  MyTheme copyWith({
    Color? background1,
    Color? background2,
    Color? btnColor1,
    Color? btnColor2,
    Color? btnTextColor,
    Color? textColor,
    Color? borderColor,
    Color? hintColor,
    TextStyle? defaultTextStyle,
    TextStyle? hintTextStyle,
    TextStyle? fieldTextStyle,
    TextStyle? btnTextStyle,
    TextStyle? textBtnTextStyle,
    TextStyle? headerTextStyle,
    Color? darkBlueColor,
    Color? redColor,
    Color? greyColor,
    Color? darkGreyColor,
    Color? redForCard,
    Color? greenForCard,
    Color? blueForCard,
    Color? buttonDisabledColor,
    Color? btnRedColor,
    Color? btnRedColor1,
    Color? diedPositiveColor,
    Color? positiveColor,
    Color? negativeColor,
    Color? diedColor,
    Color? sidebarDividerColor,
    Color? sidebarSectionTitleColor,
    Color? sidebarInactiveTextColor,
    Color? sidebarActiveItemBgColor,
    Color? cardShadowColor,
    Color? successColor,
    Color? hoverColor,
    Color? statusActiveColor,
    Color? statusActiveBgColor,
    Color? statusBillingColor,
    Color? statusBillingBgColor,
    Color? statusEndedColor,
  }) =>
      MyTheme(
        background1: background1 ?? this.background1,
        background2: background2 ?? this.background2,
        btnColor1: btnColor1 ?? this.btnColor1,
        btnColor2: btnColor2 ?? this.btnColor2,
        btnTextColor: btnTextColor ?? this.btnTextColor,
        textColor: textColor ?? this.textColor,
        borderColor: borderColor ?? this.borderColor,
        hintColor: hintColor ?? this.hintColor,
        defaultTextStyle: defaultTextStyle ?? this.defaultTextStyle,
        hintTextStyle: hintTextStyle ?? this.hintTextStyle,
        fieldTextStyle: fieldTextStyle ?? this.fieldTextStyle,
        btnTextStyle: btnTextStyle ?? this.btnTextStyle,
        textBtnTextStyle: textBtnTextStyle ?? this.textBtnTextStyle,
        headerTextStyle: headerTextStyle ?? this.headerTextStyle,
        darkBlueColor: darkBlueColor ?? this.darkBlueColor,
        redColor: redColor ?? this.redColor,
        greyColor: greyColor ?? this.greyColor,
        darkGreyColor: darkGreyColor ?? this.darkGreyColor,
        redForCard: redForCard ?? this.redForCard,
        greenForCard: greenForCard ?? this.greenForCard,
        blueForCard: blueForCard ?? this.blueForCard,
        buttonDisabledColor: buttonDisabledColor ?? this.buttonDisabledColor,
        btnRedColor: btnRedColor ?? this.btnRedColor,
        btnRedColor1: btnRedColor1 ?? this.btnRedColor1,
        diedPositiveColor: diedPositiveColor ?? this.diedPositiveColor,
        positiveColor: positiveColor ?? this.positiveColor,
        negativeColor: negativeColor ?? this.negativeColor,
        diedColor: diedColor ?? this.diedColor,
        sidebarDividerColor: sidebarDividerColor ?? this.sidebarDividerColor,
        sidebarSectionTitleColor: sidebarSectionTitleColor ?? this.sidebarSectionTitleColor,
        sidebarInactiveTextColor: sidebarInactiveTextColor ?? this.sidebarInactiveTextColor,
        sidebarActiveItemBgColor: sidebarActiveItemBgColor ?? this.sidebarActiveItemBgColor,
        cardShadowColor: cardShadowColor ?? this.cardShadowColor,
        successColor: successColor ?? this.successColor,
        hoverColor: hoverColor ?? this.hoverColor,
        statusActiveColor: statusActiveColor ?? this.statusActiveColor,
        statusActiveBgColor: statusActiveBgColor ?? this.statusActiveBgColor,
        statusBillingColor: statusBillingColor ?? this.statusBillingColor,
        statusBillingBgColor: statusBillingBgColor ?? this.statusBillingBgColor,
        statusEndedColor: statusEndedColor ?? this.statusEndedColor,
      );

  @override
  MyTheme lerp(ThemeExtension<MyTheme>? other, double t) {
    if (other is! MyTheme) return this;
    return MyTheme(
      background1: Color.lerp(background1, other.background1, t)!,
      background2: Color.lerp(background2, other.background2, t)!,
      btnColor1: Color.lerp(btnColor1, other.btnColor1, t)!,
      btnColor2: Color.lerp(btnColor2, other.btnColor2, t)!,
      btnTextColor: Color.lerp(btnTextColor, other.btnTextColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      hintColor: Color.lerp(hintColor, other.hintColor, t)!,
      defaultTextStyle: TextStyle.lerp(defaultTextStyle, other.defaultTextStyle, t)!,
      hintTextStyle: TextStyle.lerp(hintTextStyle, other.hintTextStyle, t)!,
      fieldTextStyle: TextStyle.lerp(fieldTextStyle, other.fieldTextStyle, t)!,
      btnTextStyle: TextStyle.lerp(btnTextStyle, other.btnTextStyle, t)!,
      textBtnTextStyle: TextStyle.lerp(textBtnTextStyle, other.textBtnTextStyle, t)!,
      headerTextStyle: TextStyle.lerp(headerTextStyle, other.headerTextStyle, t)!,
      darkBlueColor: Color.lerp(darkBlueColor, other.darkBlueColor, t)!,
      redColor: Color.lerp(redColor, other.redColor, t)!,
      greyColor: Color.lerp(greyColor, other.greyColor, t)!,
      darkGreyColor: Color.lerp(darkGreyColor, other.darkGreyColor, t)!,
      redForCard: Color.lerp(redForCard, other.redForCard, t)!,
      greenForCard: Color.lerp(greenForCard, other.greenForCard, t)!,
      blueForCard: Color.lerp(blueForCard, other.blueForCard, t)!,
      buttonDisabledColor: Color.lerp(buttonDisabledColor, other.buttonDisabledColor, t)!,
      btnRedColor: Color.lerp(btnRedColor, other.btnRedColor, t)!,
      btnRedColor1: Color.lerp(btnRedColor1, other.btnRedColor1, t)!,
      diedPositiveColor: Color.lerp(diedPositiveColor, other.diedPositiveColor, t)!,
      positiveColor: Color.lerp(positiveColor, other.positiveColor, t)!,
      negativeColor: Color.lerp(negativeColor, other.negativeColor, t)!,
      diedColor: Color.lerp(diedColor, other.diedColor, t)!,
      sidebarDividerColor: Color.lerp(sidebarDividerColor, other.sidebarDividerColor, t)!,
      sidebarSectionTitleColor: Color.lerp(sidebarSectionTitleColor, other.sidebarSectionTitleColor, t)!,
      sidebarInactiveTextColor: Color.lerp(sidebarInactiveTextColor, other.sidebarInactiveTextColor, t)!,
      sidebarActiveItemBgColor: Color.lerp(sidebarActiveItemBgColor, other.sidebarActiveItemBgColor, t)!,
      cardShadowColor: Color.lerp(cardShadowColor, other.cardShadowColor, t)!,
      successColor: Color.lerp(successColor, other.successColor, t)!,
      hoverColor: Color.lerp(hoverColor, other.hoverColor, t)!,
      statusActiveColor: Color.lerp(statusActiveColor, other.statusActiveColor, t)!,
      statusActiveBgColor: Color.lerp(statusActiveBgColor, other.statusActiveBgColor, t)!,
      statusBillingColor: Color.lerp(statusBillingColor, other.statusBillingColor, t)!,
      statusBillingBgColor: Color.lerp(statusBillingBgColor, other.statusBillingBgColor, t)!,
      statusEndedColor: Color.lerp(statusEndedColor, other.statusEndedColor, t)!,
    );
  }
}
