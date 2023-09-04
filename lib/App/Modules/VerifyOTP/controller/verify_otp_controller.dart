import 'package:e_jareemah/App/Models/Main/user_model.dart';
import 'package:e_jareemah/App/Modules/Dashboard/binding/dashboard_binding.dart';
import 'package:e_jareemah/App/Modules/Dashboard/view/dashboard_view.dart';
import 'package:e_jareemah/App/Modules/SignUp/controller/sign_up_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Services/AuthenticationService/Core/manager.dart';

class VerifyOTPController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  final TextEditingController otpEditingController = TextEditingController();
  final bool register = Get.arguments;
  RxBool isLoading = false.obs;

  Future<void> verifyOtp(String verificationId) async {
    await authManager.firebaseServices.verifyOtp(
      verificationId: verificationId,
      userOtp: otpEditingController.text,
      onSuccess: (User user) {
        authManager.firebaseServices
            .checkExistingUser(user.uid)
            .then((value) async {
          if (value == true) {
            if (register) {
              Get.back();

              appTools.showErrorSnackBar('thisNumberExist'.tr);
              return;
            } else {
              // user exists in our app
              authManager.firebaseServices
                  .getDataFromFireStore()
                  .then((value) async {
                if (value.userId != null) {
                  authManager.login(value);
                  appTools.showSuccessSnackBar('loginSuccess'.tr);
                  Get.to(() => const DashboardView(),
                      binding: DashboardBinding());
                } else {
                  await authManager.firebaseServices.userSignOut();
                  appTools.showErrorSnackBar('error'.tr);
                  Get.back();
                }
              });
            }
          } else {
            // new user
            if (register) {
              final SignUpController signUpController = Get.find();

              UserModel newModel =
                  UserModel.fromJson(signUpController.registerDTO.toJson());
              newModel.userId = user.uid;

              bool result =
                  await authManager.firebaseServices.saveUserDataToFirebase(
                userModel: newModel,
              );
              if (result) {
                appTools.showSuccessSnackBar('registerSuccess'.tr);

                Get.to(() => const DashboardView(),
                    binding: DashboardBinding());
              } else {
                appTools.showErrorSnackBar('registerFailed'.tr);
              }
            } else {
              authManager.logOut();
              appTools.showErrorSnackBar('thisNumberNotExist'.tr);
            }
          }
        });
      },
    );
  }

  @override
  void onClose() {
    otpEditingController.dispose();
    super.onClose();
  }
}
