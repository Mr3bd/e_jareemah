import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Models/enums/enums.dart';
import '../Constants/AppColors.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class AppTools {
  void unFocusKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void showSuccessSnackBar(String message, {int seconds = 0}) {
    showTaxiSnackBar(message, SnackEnum.success, seconds);
  }

  void showErrorSnackBar(String message, {int seconds = 0}) {
    showTaxiSnackBar(message, SnackEnum.error, seconds);
  }

  void showWarningSnackBar(String message, {int seconds = 0}) {
    showTaxiSnackBar(message, SnackEnum.warning, seconds);
  }

  void showTaxiSnackBar(String message, SnackEnum snackEnum, int seconds) {
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

  String encryptPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  int createRandom() {
    int randomID;
    Random random = Random();
    int randomFirst = random.nextInt(1000000000) + 1000000;
    int randomSecond = random.nextInt(100000) + randomFirst;
    randomID = randomFirst + randomSecond;
    return randomID;
  }
}
