import 'package:flutter/material.dart';

class AppStyles {
  /// Colors
  static Color primary = Color(0xFF82F155);
  static Color secondary = Color(0xFFFF8A69);
  static Color primaryContainer = Color(0xFFDAFFBF);
  static Color onPrimaryContainer = Color(0xFF172812);
  static Color secondaryContainer = Color(0xFFFFCBAF);
  static Color onSecondaryContainer = Color(0xFF3A2819);
  static Color background = Color(0xFFE7FFD8);
  static Color onBackground = Color(0xFF18210B);

  static const textTheme = TextTheme(
    bodyLarge: TextStyle(fontSize: 14),
    bodyMedium: TextStyle(fontSize: 12),
    bodySmall: TextStyle(fontSize: 11),
    titleLarge: TextStyle(fontSize: 22),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    labelLarge: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),
    labelMedium: TextStyle(fontSize: 11,fontWeight: FontWeight.w500),
    labelSmall: TextStyle(fontSize: 10,fontWeight: FontWeight.w500),
  );

  static ThemeData getAppTheme(BuildContext context) {
    return ThemeData(
        colorSchemeSeed: Colors.greenAccent,
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppStyles.onPrimaryContainer),
              borderRadius: BorderRadius.circular(18)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppStyles.onPrimaryContainer),
              borderRadius: BorderRadius.circular(18)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 40)),
                textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(color: primaryContainer, fontWeight: FontWeight.w500)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        )))));
  }
}
