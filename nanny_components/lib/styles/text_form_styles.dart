import 'package:flutter/material.dart';
import 'package:nanny_components/nanny_components.dart';

class NannyTextFormStyles {
  static final InputDecorationTheme defaultFormTheme = InputDecorationTheme(
    hintStyle: NannyTextStyles.textTheme.labelLarge,
    labelStyle: NannyTextStyles.textTheme.labelLarge,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  );

  static const InputDecoration searchForm = InputDecoration(
      fillColor: NannyTheme.surface,
      filled: true,
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      suffixIcon: Icon(Icons.search_rounded),
      suffixIconColor: NannyTheme.onSurface);
}
