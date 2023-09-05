import 'package:e_jareemah/App/Models/Main/DTO/register_dto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Services/AuthenticationService/Core/manager.dart';

class SignUpController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  final TextEditingController idEditingController = TextEditingController();
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController phoneEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();
  RxBool isLoading = false.obs;
  RegisterDTO registerDTO = RegisterDTO();
  Future<void> sendPhoneNumber() async {
    registerDTO = RegisterDTO();
    if (nameEditingController.text.isEmpty) {
      appTools.showErrorSnackBar('enterFullname'.tr);
      return;
    } else if (idEditingController.text.isEmpty) {
      appTools.showErrorSnackBar('enterNationalIdNumber'.tr);
      return;
    } else if (phoneEditingController.text.isEmpty) {
      appTools.showErrorSnackBar('enterPhone'.tr);
      return;
    } else if (passwordEditingController.text.isEmpty) {
      appTools.showErrorSnackBar('enterPassword'.tr);
      return;
    }

    String phoneNumber = phoneEditingController.text.trim();
    if (phoneNumber[0] == '0') {
      phoneNumber = '+962${phoneNumber.substring(1)}';
    } else {
      appTools.showErrorSnackBar('enterValidPhone'.tr);
      return;
    }
    isLoading.value = true;
    registerDTO = RegisterDTO(
        phone: phoneNumber,
        nId: idEditingController.text,
        name: nameEditingController.text,
        date: DateTime.now().toString(),
        password: appTools.encryptPassword(passwordEditingController.text));
    await authManager.firebaseServices.signInWithPhone(registerDTO, true);
  }

  @override
  void onClose() {
    idEditingController.dispose();
    nameEditingController.dispose();
    phoneEditingController.dispose();
    passwordEditingController.dispose();
    super.onClose();
  }
}
