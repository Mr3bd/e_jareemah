import 'package:e_jareemah/App/Models/Main/user_model.dart';
import 'package:e_jareemah/App/Modules/Dashboard/binding/dashboard_binding.dart';
import 'package:e_jareemah/App/Modules/Dashboard/view/dashboard_view.dart';
import 'package:e_jareemah/App/Modules/SignUp/controller/sign_up_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../Services/AuthenticationService/Core/manager.dart';

class VerifyOTPController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  final bool register = Get.arguments;
  final TextEditingController otp = TextEditingController();
  RxBool isLoading = false.obs;
  RxString otpCode = ''.obs;
  RxBool validOtp = true.obs;

  @override
  void onInit() {
    _listenSmsCode();

    super.onInit();
  }

  _listenSmsCode() async {
    await SmsAutoFill().listenForCode();
  }

  Future<void> verifyOtp(String verificationId) async {
    isLoading.value = true;
    await authManager.firebaseServices.verifyOtp(
      verificationId: verificationId,
      userOtp: getOtpValue(),
      onSuccess: (User user) {
        if (register) {
          final SignUpController signUpController = Get.find();
          authManager.firebaseServices
              .checkExistingUser(UserModel(
                  phone: signUpController.registerDTO.phone,
                  nId: signUpController.registerDTO.nId))
              .then((value) async {
            if (value == true) {
              Get.back();

              appTools.showErrorSnackBar('thisNumberOrNIdExist'.tr);
              isLoading.value = false;
              return;
            } else {
              UserModel newModel =
                  UserModel.fromJson(signUpController.registerDTO.toJson());
              newModel.userId = user.uid;

              bool result =
                  await authManager.firebaseServices.saveUserDataToFirebase(
                userModel: newModel,
              );
              if (result) {
                authManager.appUser.value = newModel;
                appTools.showSuccessSnackBar('registerSuccess'.tr);

                Get.offAll(() => const DashboardView(),
                    binding: DashboardBinding());
              } else {
                isLoading.value = false;
                appTools.showErrorSnackBar('registerFailed'.tr);
              }
            }
          });
        } else {
          authManager.firebaseServices
              .getDataFromFireStore()
              .then((value) async {
            isLoading.value = false;

            if (value.userId != null) {
              authManager.login(value);
              appTools.showSuccessSnackBar('loginSuccess'.tr);
              Get.offAll(() => const DashboardView(),
                  binding: DashboardBinding());
            } else {
              await authManager.firebaseServices.userSignOut();
              appTools.showErrorSnackBar('error'.tr);
              Get.back();
            }
          });
        }
      },
    );
  }

  @override
  void onClose() {
    SmsAutoFill().unregisterListener();
    super.onClose();
  }

  bool checkIfOtpValid() {
    final numberReg = RegExp(r'^[0-9]{6,6}$');
    return otpCode.value.isNotEmpty && numberReg.hasMatch(otpCode.value);
  }

  String getOtpValue() {
    return otpCode.value;
  }
}
