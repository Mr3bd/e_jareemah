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
    String phoneNumber = nIdEditingController.text.trim();
    if (phoneNumber[0] == '0') {
      phoneNumber = '+962${phoneNumber.substring(1)}';
    } else {
      appTools.showErrorSnackBar('enterValidPhone'.tr);
      return;
    }
    await authManager.firebaseServices
        .signInWithPhone(RegisterDTO(phone: phoneNumber), false);
  }

  @override
  void onInit() {
    super.onInit();
  }
}
