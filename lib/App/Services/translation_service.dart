import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Utilities/Lang/ar.dart';
import '../Utilities/Lang/en.dart';

class TranslationService extends Translations {
  GetStorage localStorage = GetStorage();

  static const locale = Locale('ar', 'JO');
  static const fallbackLocale = Locale('ar', 'JO');

  static final langs = [
    'ar_JO',
    'en_US',
  ];

  static final locales = [
    const Locale('ar', 'JO'),
    const Locale('en', 'US'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        'ar_JO': ar,
        'en_US': en,
      };

  void changeLocale(String lang) async {
    if (lang == langs[0]) {
      Get.updateLocale(locales[0]);
      await localStorage.write('language', 'ar_JO');
    } else {
      Get.updateLocale(locales[1]);
      await localStorage.write('language', 'en_US');
    }
  }

  Locale getLocale() {
    String? currentLocale = localStorage.read('language');
    if (currentLocale == null || currentLocale == 'ar_JO') return locales[0];

    return locales[0];
  }

  bool isLocaleArabic() {
    return Get.locale == const Locale('ar', 'JO');
  }
}
