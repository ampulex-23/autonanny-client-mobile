import 'package:flutter/material.dart';
import 'package:nanny_components/styles/nanny_theme.dart';

class NannyButtonStyles {
  static final ElevatedButtonThemeData elevatedBtnTheme =
      ElevatedButtonThemeData(style: defaultButtonStyle);
  static final TextButtonThemeData textBtnTheme =
      TextButtonThemeData(style: defaultButtonStyleWithNoSize);

  static final ButtonThemeData defaultButtonTheme = ButtonThemeData(
      shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ));

  static final ButtonStyle defaultButtonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(200, 50),
      maximumSize: const Size(double.infinity, 100),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ));

  static final ButtonStyle defaultButtonStyleWithNoSize =
      ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ));

  static const ButtonStyle whiteButton = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(NannyTheme.secondary),
    foregroundColor: MaterialStatePropertyAll(NannyTheme.onSecondary),
    overlayColor: MaterialStatePropertyAll(NannyTheme.lightPink),
  );

  static const ButtonStyle lightGreen = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(NannyTheme.lightGreen),
    foregroundColor: MaterialStatePropertyAll(NannyTheme.onSecondary),
    overlayColor: MaterialStatePropertyAll(NannyTheme.green),
  );

  static const ButtonStyle green = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(NannyTheme.green),
    foregroundColor: MaterialStatePropertyAll(NannyTheme.onSecondary),
    overlayColor: MaterialStatePropertyAll(NannyTheme.lightGreen),
  );

  static const ButtonStyle transparent = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(Colors.transparent),
    foregroundColor: MaterialStatePropertyAll(NannyTheme.onSecondary),
    overlayColor: MaterialStatePropertyAll(NannyTheme.grey),
    elevation: MaterialStatePropertyAll(0),
  );

  static ButtonStyle main = ButtonStyle(
    elevation: const WidgetStatePropertyAll(2),
    backgroundColor: const WidgetStatePropertyAll(NannyTheme.primary),
    foregroundColor: const WidgetStatePropertyAll(NannyTheme.secondary),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    minimumSize: const WidgetStatePropertyAll(
      Size(double.infinity, 60),
    ),
  );

  static ButtonStyle secondary = ButtonStyle(
    elevation: const WidgetStatePropertyAll(2),
    backgroundColor: const WidgetStatePropertyAll(NannyTheme.secondary),
    foregroundColor: const WidgetStatePropertyAll(NannyTheme.onSecondary),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    minimumSize: const WidgetStatePropertyAll(
      Size(double.infinity, 60),
    ),
  );
}
