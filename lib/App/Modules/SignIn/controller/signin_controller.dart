import 'package:e_jareemah/App/Models/Main/DTO/register_dto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Services/AuthenticationService/Core/manager.dart';

class SignInController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  final TextEditingController nIdEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> login() async {
    if (nIdEditingController.text.isEmpty) {
      appTools.showErrorSnackBar('enterNationalIdNumber'.tr);
      return;
    } else if (passwordEditingController.text.isEmpty) {
      appTools.showErrorSnackBar('enterPassword'.tr);
      return;
    }
    isLoading.value = true;
    String? phone = await authManager.firebaseServices.getUserPhone(
        nIdEditingController.text,
        appTools.encryptPassword(passwordEditingController.text));

    if (phone != null) {
      await authManager.firebaseServices
          .signInWithPhone(RegisterDTO(phone: phone), false);
    } else {
      isLoading.value = false;
      appTools.showErrorSnackBar('invalidData'.tr);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
