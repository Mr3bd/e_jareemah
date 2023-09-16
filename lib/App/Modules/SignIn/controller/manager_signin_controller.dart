import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Services/AuthenticationService/Core/manager.dart';
import '../../Dashboard/binding/dashboard_binding.dart';
import '../../Dashboard/view/dashboard_view.dart';

class ManagerSignInController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  final TextEditingController passwordEditingController =
      TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> login() async {
    if (passwordEditingController.text.isEmpty) {
      appTools.showErrorSnackBar('enterPassword'.tr);
      return;
    }
    isLoading.value = true;
    String? email = await authManager.firebaseServices
        .getEmail(passwordEditingController.text);

    if (email != null) {
      bool result = await authManager.firebaseServices.loginUsingEmailPassword(
          email: email, password: passwordEditingController.text);

      if (result) {
        appTools.showSuccessSnackBar('loginSuccess'.tr);
        Get.offAll(() => const DashboardView(), binding: DashboardBinding());
      }
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
