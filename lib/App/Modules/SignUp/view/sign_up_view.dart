import 'package:e_jareemah/App/Utilities/Widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Services/AuthenticationService/Core/manager.dart';
import '../../../Utilities/Constants/AppColors.dart';
import '../../../Utilities/Widgets/app_logo.dart';
import '../controller/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          appTools.unFocusKeyboard(context);
        },
        child: Scaffold(
          backgroundColor: AppColors.primaryBackground,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            titleSpacing: 0.0,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black54,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 36.0, vertical: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const AppLogo(
                    withTitle: true,
                  ),
                  const SizedBox(height: 32.0),
                  TextFormField(
                      autofocus: false,
                      controller: controller.idEditingController,
                      keyboardType: TextInputType.number,
                      validator: (value) {},
                      onSaved: (value) {
                        controller.idEditingController.text = value!;
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
                      controller: controller.nameEditingController,
                      keyboardType: TextInputType.text,
                      validator: (value) {},
                      onSaved: (value) {
                        controller.nameEditingController.text = value!;
                      },
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        fillColor: AppColors.grey.withOpacity(0.1),
                        filled: true,
                        hintText: "الاسم الرباعي",
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
                      controller: controller.phoneEditingController,
                      validator: (value) {},
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        controller.phoneEditingController.text = value!;
                      },
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        fillColor: AppColors.grey.withOpacity(0.1),
                        filled: true,
                        hintText: "0791234567",
                        label: const Text("رقم الهاتف"),
                        hintStyle: TextStyle(
                          color: AppColors.grey.withOpacity(0.3),
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
                      validator: (value) {},
                      keyboardType: TextInputType.text,
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
                  const SizedBox(height: 32.0),
                  Obx(
                    () => CustomButton(
                        text: controller.isLoading.value ? null : 'تسجيل',
                        onTap: controller.isLoading.value
                            ? () {}
                            : () => controller.sendPhoneNumber(),
                        child: controller.isLoading.value
                            ? const CupertinoActivityIndicator(
                                color: AppColors.white,
                              )
                            : null),
                  ),
                  const SizedBox(height: 32.0),
                ],
              ),
            ),
          ),
        ));
  }
}
