import 'package:e_jareemah/App/Modules/SignIn/binding/signin_binding.dart';
import 'package:e_jareemah/App/Modules/SignIn/view/signin_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Services/AuthenticationService/Core/manager.dart';
import '../../../Utilities/Constants/AppColors.dart';
import '../../../Utilities/Widgets/app_logo.dart';
import '../../../Utilities/Widgets/custom_button.dart';
import '../controller/manager_signin_controller.dart';

class ManagerSignInView extends GetView<ManagerSignInController> {
  const ManagerSignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          appTools.unFocusKeyboard(context);
        },
        child: Scaffold(
          backgroundColor: AppColors.primaryBackground,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 64.0,
                  ),
                  const AppLogo(
                    manager: true,
                  ),
                  const SizedBox(height: 40.0),
                  TextFormField(
                      autofocus: false,
                      controller: controller.passwordEditingController,
                      obscureText: true,
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{6,}$');
                        if (value!.isEmpty) {
                          return ("Password is required for login");
                        }
                        if (!regex.hasMatch(value)) {
                          return ("Enter Valid Password(Min. 6 Character)");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        controller.passwordEditingController.text = value!;
                      },
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        fillColor: AppColors.grey.withOpacity(0.1),
                        filled: true,
                        hintText: "كلمة السر: 123456",
                        label: Text(
                          "كلمة السر للجهة الأمنيّة",
                          style: Get.textTheme.labelLarge!
                              .copyWith(color: AppColors.grey),
                        ),
                        hintStyle: const TextStyle(
                          color: AppColors.grey,
                        ),
                        contentPadding: const EdgeInsets.all(8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.managerColor.withOpacity(0.4),
                              width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColors.transparent, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //    GestureDetector(
                      //    onTap: () => appTools
                      //      .showEncryptionDialog(AppColors.managerColor),
                      // child: Row(
                      //                       children: [
                      //                       Icon(
                      //                       Icons.lock_person,
                      //                     color: AppColors.managerColor.withOpacity(0.5),
                      //                 ),
                      //               const SizedBox(
                      //               width: 8.0,
                      //           ),
                      //         const Text('جميع البيانات مشفرة'),
                      //     ],
                      // ),
                      //    ),
                      GestureDetector(
                          onTap: () => Get.off(() => const SignInView(),
                              binding: SignInBinding()),
                          child: const Text(
                            'دخول كمواطن',
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
//                  Row(
                  //                  crossAxisAlignment: CrossAxisAlignment.start,
                  //                children: [
                  //                Icon(
                  //                Icons.info,
                  //                   color: AppColors.managerColor.withOpacity(0.5),
                  //               ),
                  //             const SizedBox(
                  //             width: 8.0,
                  //         ),
                  //                   SizedBox(
                  //                 width: Get.width * 0.7,
                  //                   child: const Text(
                  //                   'نظراً لأن هذه النسخة تجريبية، ادخل كلمة السّر التالية: 123456 للدخول كمشرف'),
                  //           ),
                  //       ],
                  //   ),
                  const SizedBox(height: 128.0),
                  Obx(
                    () => CustomButton(
                        text: controller.isLoading.value ? null : 'دخول',
                        onTap: controller.isLoading.value
                            ? () {}
                            : () => controller.login(),
                        color: AppColors.managerColor,
                        child: controller.isLoading.value
                            ? const CupertinoActivityIndicator(
                                color: AppColors.white,
                              )
                            : null),
                  ),
                  const SizedBox(height: 48.0),
                ],
              ),
            ),
          ),
        ));
  }
}
