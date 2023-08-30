import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Utilities/Constants/AppColors.dart';


class SettingsService extends GetxService {

  Future<SettingsService> init() async {
    return this;
  }

  ThemeData getLightTheme() {
    return ThemeData(
      // highlightColor: AppColors.transparent,
      // splashColor: AppColors.transparent,
      primaryColor: AppColors.primary,
      hoverColor: AppColors.success,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 3,
        foregroundColor: AppColors.white,
        highlightElevation: 6,
        disabledElevation: 2,
      ),
      brightness: Brightness.light,
      dividerColor: AppColors.grey,
      focusColor: AppColors.primary,
      hintColor: AppColors.grey,
      // bottomSheetTheme:
      //     const BottomSheetThemeData(backgroundColor: AppColors.tra),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            foregroundColor: AppColors.black,
            textStyle: const TextStyle(
              fontWeight: FontWeight.w300,
            )),
      ),
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
      ),
      fontFamily:
          getLocale().toString().startsWith('ar') ? 'NotoKufiArabic' : 'Roboto',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 57.0,
          fontWeight: FontWeight.w300,
          color: AppColors.black,
          height: 1.2,
        ),
        displayMedium: TextStyle(
          fontSize: 45.0,
          fontWeight: FontWeight.w300,
          color: AppColors.black,
          height: 1.2,
        ),
        displaySmall: TextStyle(
          fontSize: 36.0,
          fontWeight: FontWeight.w300,
          color: AppColors.black,
          height: 1.2,
        ),
        headlineLarge: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.w300,
          color: AppColors.black,
          height: 1.2,
        ),
        headlineMedium: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w300,
          color: AppColors.black,
          height: 1.2,
        ),
        headlineSmall: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w300,
          color: AppColors.black,
          height: 1.2,
        ),
        titleLarge: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w300,
          color: AppColors.black,
          height: 1.2,
        ),
        titleMedium: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w300,
          color: AppColors.black,
          height: 1.2,
        ),
        titleSmall: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w300,
          color: AppColors.black,
          height: 1.2,
        ),
        bodyLarge: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w300,
          color: AppColors.black,
          height: 1.4,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w300,
          color: AppColors.black,
          height: 1.4,
        ),
        bodySmall: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w300,
          color: AppColors.black,
          height: 1.2,
        ),
      ),
    );
  }

  Locale getLocale() {
    String? localeLang = GetStorage().read<String>('lang');
    String? localeCountry = GetStorage().read<String>('country');
    Locale locale = localeLang == null || localeCountry == null
        ? const Locale('ar', 'JO')
        : const Locale('en', 'US');

    return locale;
  }
}
