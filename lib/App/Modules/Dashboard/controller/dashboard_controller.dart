import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Services/AuthenticationService/Core/manager.dart';

class DashboardController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }
}
