import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Services/AuthenticationService/Core/manager.dart';

class SignUpController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController userNameEditingController =
      TextEditingController();
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();
  RxBool isLoading = false.obs;
}
