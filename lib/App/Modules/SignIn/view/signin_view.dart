import 'package:e_jareemah/App/Modules/SignUp/binding/sign_up_binding.dart';
import 'package:e_jareemah/App/Modules/SignUp/view/sign_up_view.dart';
import 'package:e_jareemah/App/Services/AuthenticationService/Core/manager.dart';
import 'package:e_jareemah/App/Utilities/Widgets/app_logo.dart';
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
          backgroundColor: Colors.white,
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
                  const Row(
                    children: [
                      Text('دخول كمشرف'),
                    ],
                  ),
                  const SizedBox(height: 32.0),
                  SizedBox(
                    width: Get.width * 0.6,
                    height: Get.width * 0.1,
                    child: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.circular(8.0),
                      color: AppColors.primary,
                      child: MaterialButton(
                          padding: const EdgeInsets.all(4.0),
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () => controller.login(),
                          child: const Text(
                            "دخول",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    width: Get.width * 0.6,
                    height: Get.width * 0.1,
                    child: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.circular(8.0),
                      color: AppColors.primary,
                      child: MaterialButton(
                          padding: const EdgeInsets.all(4.0),
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () {
                            Get.to(() => const SignUpView(),
                                binding: SignUpBinding());
                          },
                          child: const Text(
                            "إنشاء حساب",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                ],
              ),
            ),
          ),
        ));
  }
}
