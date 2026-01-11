import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_components/styles/checkbox_styles.dart';

class NannyTheme {
  static final ThemeData appTheme = ThemeData(
      colorScheme: colorScheme,
      buttonTheme: NannyButtonStyles.defaultButtonTheme,
      elevatedButtonTheme: NannyButtonStyles.elevatedBtnTheme,
      textButtonTheme: NannyButtonStyles.textBtnTheme,
      textTheme: NannyTextStyles.textTheme,
      inputDecorationTheme: NannyTextFormStyles.defaultFormTheme,
      dialogTheme: dialogTheme,
      floatingActionButtonTheme: defaultFABStyle,
      cardTheme: defaultCardStyle,
      checkboxTheme: defaultCheckboxStyle,
      useMaterial3: false);

  static const colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: onPrimary,
    secondary: secondary,
    onSecondary: onSecondary,
    error: error,
    onError: onError,
    background: background,
    onBackground: onBackground,
    surface: surface,
    onSurface: onSurface,
  );

  static const Color primary = Color(0xFF7067F2);
  static const Color onPrimary = Color(0xFFFFFFFF);

  static const Color secondary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFF000000);

  static const Color error = Colors.redAccent;
  static const Color onError = Colors.red;

  static const Color background = Color(0xFFE6E4FF);
  static const Color onBackground = Color(0xFF000000);

  static const Color surface = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF000000);

  static const Color grey = Color(0xFFE6E6E6);
  static const Color darkGrey = Color(0xFFBEBEBE);
  static const Color green = Color(0xFF6EE481);
  static const Color lightGreen = Color(0xFFE2FFE3);
  static const Color lightPink = Color(0xFFF6F5FF);

  static const Color shadow = Color(0xFF605B99);

  static final ShapeBorder roundBorder =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20));
}
