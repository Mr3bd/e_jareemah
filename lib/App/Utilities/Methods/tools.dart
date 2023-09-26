import 'dart:math';
import 'package:e_jareemah/App/Utilities/Constants/AppStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Models/enums/enums.dart';
import '../Constants/AppColors.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

import '../Widgets/open_single_image_dialog.dart';

class AppTools {
  void unFocusKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void showSuccessSnackBar(String message, {int seconds = 0}) {
    showJareemahSnackBar(message, SnackEnum.success, seconds);
  }

  void showErrorSnackBar(String message, {int seconds = 0}) {
    showJareemahSnackBar(message, SnackEnum.error, seconds);
  }

  void showWarningSnackBar(String message, {int seconds = 0}) {
    showJareemahSnackBar(message, SnackEnum.warning, seconds);
  }

  void openImage(String path) {
    Get.dialog(OpenSingleImageDialog(path: path),
        useSafeArea: false, barrierColor: AppColors.black);
  }

  void showJareemahSnackBarWithAction(
      String message, String actionTitle, VoidCallback onTap,
      {int seconds = 0}) {
    final SnackBar snackBar = SnackBar(
      padding: const EdgeInsets.all(4.0),
      content: Text(
        message,
        style: Get.textTheme.bodySmall!.copyWith(color: AppColors.white),
      ),
      backgroundColor: AppColors.warning,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 5),
      action: SnackBarAction(
          label: actionTitle, textColor: Colors.white, onPressed: onTap),
    );

    Future.delayed(Duration(seconds: seconds), () {
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    });
  }

  void showJareemahSnackBar(String message, SnackEnum snackEnum, int seconds) {
    final SnackBar snackBar = SnackBar(
      content: Text(
        message,
        style: Get.textTheme.labelMedium!.copyWith(color: AppColors.white),
      ),
      backgroundColor: snackEnum == SnackEnum.success
          ? AppColors.success
          : snackEnum == SnackEnum.error
              ? AppColors.error
              : AppColors.warning,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 5),
      action: SnackBarAction(
          label: 'dismiss'.tr, textColor: Colors.white, onPressed: () {}),
    );

    Future.delayed(Duration(seconds: seconds), () {
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    });
  }

  Future<void> openMap(BuildContext context, double lat, double lng) async {
    String url = '';

    url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  void openURL(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) throw 'Could not launch $url';
  }

  void showEncryptionDialog(Color themeColor) {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Center(child: Text("نظام التشفير")),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.lock_person,
              color: themeColor.withOpacity(0.5),
              size: 64.0,
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              'نستخدم نظام التشفير بإستخدام عدة خوارزميات مثل SHA256، كم نستخدم أسلوب تشفير End-to-end، ويضمن هذه الأسلوب حماية سرية وصحة البيانات وعدم التلاعب والإطلاع عليها من قبل أشخاص غير مخولين لهم.',
              style: Get.textTheme.labelLarge,
            )
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(AppStyles.borderRadius))),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Container(
              color: themeColor,
              padding: const EdgeInsets.all(14),
              child: Text(
                "رجوع",
                style:
                    Get.textTheme.titleMedium!.copyWith(color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String encryptPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  int createRandom() {
    int randomID;
    Random random = Random();
    int randomFirst = random.nextInt(10000000) + 10000;
    int randomSecond = random.nextInt(10000) + randomFirst;
    randomID = randomFirst + randomSecond;
    return randomID;
  }
    void showAPI(Color themeColor) {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
                       'assets/icons/google.png',
                      width: Get.width * 0.15,
                     ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
             'يتم تقييم الروابط بواسطة جوجل API v4 من خلال البحث في قواعد بيانات خاصة تحتوي على المواقع الخبيثة',
              style: Get.textTheme.labelLarge,
            )
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(AppStyles.borderRadius))),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Container(
              color: themeColor,
              padding: const EdgeInsets.all(14),
              child: Text(
                "رجوع",
                style:
                    Get.textTheme.titleMedium!.copyWith(color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
