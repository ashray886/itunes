import 'package:flutter/material.dart';
import 'package:itunes/config/colors.dart';

class CustomTheme {
  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
    );
  }

  static ThemeData darkThemeData(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      textTheme: ThemeData.dark().textTheme.apply(
            bodyColor: ITunesColors.whiteColor,
          ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: ITunesColors.whiteColor,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: ITunesColors.darkGreyColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(color: ITunesColors.whiteColor),
      ),
      chipTheme: const ChipThemeData(
        backgroundColor: ITunesColors.lightGreyColor,
        selectedColor: ITunesColors.whiteColor,
        labelStyle: TextStyle(color: ITunesColors.whiteColor),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: ITunesColors.blackColor,
        foregroundColor: ITunesColors.whiteColor,
        centerTitle: true,
      ),
      dividerTheme: const DividerThemeData(
          space: 1, color: ITunesColors.darkGreyColor, thickness: 1.0),
      listTileTheme: const ListTileThemeData(
          selectedColor: ITunesColors.whiteColor,
          textColor: ITunesColors.whiteColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: Theme.of(context).textTheme.titleMedium,
            padding: const EdgeInsets.symmetric(vertical: 15),
            foregroundColor: Colors.white,
            backgroundColor: ITunesColors.darkGreyColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: ITunesColors.blueColor)),
      scaffoldBackgroundColor: ITunesColors.scaffoldBackgroundColor,
    );
  }
}
