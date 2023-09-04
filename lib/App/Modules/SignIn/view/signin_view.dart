import 'package:e_jareemah/App/Modules/SignUp/binding/sign_up_binding.dart';
import 'package:e_jareemah/App/Modules/SignUp/view/sign_up_view.dart';
import 'package:e_jareemah/App/Services/AuthenticationService/Core/manager.dart';
import 'package:e_jareemah/App/Utilities/Widgets/app_logo.dart';
import 'package:e_jareemah/App/Utilities/Widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utilities/Constants/AppColors.dart';
import '../controller/signin_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          appTools.unFocusKeyboard(context);
        },
        child: Scaffold(
          backgroundColor: AppColors.primaryBackground,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 48.0,
                  ),
                  const AppLogo(
                    withTitle: true,
                  ),
                  const SizedBox(height: 32.0),
                  TextFormField(
                      autofocus: false,
                      controller: controller.nIdEditingController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Please Enter Your Email");
                        }
                        // reg expression for email validation
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                          return ("Please Enter a valid email");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        controller.nIdEditingController.text = value!;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        fillColor: AppColors.grey.withOpacity(0.1),
                        filled: true,
                        hintText: "الرقم الوطني",
                        hintStyle: const TextStyle(
                          color: AppColors.grey,
                        ),
                        contentPadding: const EdgeInsets.all(8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.primary.withOpacity(0.4),
                              width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColors.transparent, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )),
                  const SizedBox(height: 16.0),
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
                        hintText: "كلمة السّر",
                        hintStyle: const TextStyle(
                          color: AppColors.grey,
                        ),
                        contentPadding: const EdgeInsets.all(8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.primary.withOpacity(0.4),
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
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.lock_person,
                            color: AppColors.primary.withOpacity(0.5),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          const Text('جميع بياناتك مشفرة'),
                        ],
                      ),
                      Text(
                        'دخول كمشرف',
                        style: Get.textTheme.labelLarge!
                            .copyWith(color: AppColors.primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32.0),
                  Obx(
                    () => CustomButton(
                        text: controller.isLoading.value ? null : 'دخول',
                        onTap: controller.isLoading.value
                            ? () {}
                            : () => controller.login(),
                        child: controller.isLoading.value
                            ? const CupertinoActivityIndicator(
                                color: AppColors.white,
                              )
                            : null),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  CustomButton(
                    text: "إنشاء حساب",
                    onTap: () {
                      Get.to(() => const SignUpView(),
                          binding: SignUpBinding());
                    },
                  ),
                  const SizedBox(height: 32.0),
                ],
              ),
            ),
          ),
        ));
  }
}
