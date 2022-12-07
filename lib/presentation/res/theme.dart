import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../common/gen/colors.gen.dart';

/// https://flutter.dev/docs/release/breaking-changes/theme-data-accent-properties#migration-guide
ThemeData getAppTheme() {
  final base = ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
  );
  return base.copyWith(
    primaryColor: ColorName.primary,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: ColorName.primary,
      textTheme: ButtonTextTheme.normal,
    ),
    appBarTheme: base.appBarTheme.copyWith(
      iconTheme: base.iconTheme.copyWith(color: Colors.white),
    ),
    floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
      backgroundColor: ColorName.primary,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
      backgroundColor: Colors.white,
      selectedItemColor: ColorName.primary,
      unselectedItemColor: Colors.black.withOpacity(0.4),
    ),
    cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
      brightness: Brightness.light,
      textTheme: CupertinoTextThemeData(
        dateTimePickerTextStyle: base.textTheme.bodyText2!.copyWith(
          fontSize: 15,
        ),
      ),
    ),
  );
}

ThemeData getAppThemeDark() {
  final base = ThemeData.from(
    useMaterial3: false,
    colorScheme: const ColorScheme.dark(),
  );
  return base.copyWith(
    primaryColor: ColorName.primary,
    colorScheme: base.colorScheme.copyWith(
      primary: ColorName.primary,
    ),
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: ColorName.primary,
      textTheme: ButtonTextTheme.normal,
    ),
    appBarTheme: base.appBarTheme.copyWith(
      iconTheme: base.iconTheme.copyWith(color: Colors.white),
    ),
    floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
      backgroundColor: ColorName.primary,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
      selectedItemColor: ColorName.primary,
    ),
    cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
      brightness: Brightness.dark,
      textTheme: CupertinoTextThemeData(
        dateTimePickerTextStyle: base.textTheme.bodyText2!.copyWith(
          fontSize: 15,
        ),
      ),
    ),
  );
}
