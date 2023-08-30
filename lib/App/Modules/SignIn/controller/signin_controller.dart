import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Services/AuthenticationService/Core/manager.dart';

class SignInController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }
}
