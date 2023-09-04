import 'package:e_jareemah/App/Utilities/Constants/AppStyles.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Services/AuthenticationService/Core/manager.dart';
import '../../../Utilities/Constants/AppColors.dart';
import '../../../Utilities/Widgets/app_logo.dart';
import '../../Dashboard/binding/dashboard_binding.dart';
import '../../Dashboard/view/dashboard_view.dart';
import '../../SignIn/binding/signin_binding.dart';
import '../../SignIn/view/signin_view.dart';

class SplashController extends GetxController {
  final AuthenticationManager _authmanager = Get.put(AuthenticationManager());
  final GetStorage globalStorage = GetStorage();
  bool? firstTime;
  Future<void> initializeSettings() async {
    await _authmanager.checkLoginStatus();
  }

  @override
  Future<void> onInit() async {
    await initializeSettings();
    Future.delayed(
        Duration(seconds: _authmanager.isLogged.value == true ? 1 : 3), () {
      if (_authmanager.isLogged.value) {
        DashboardBinding().dependencies();
        Get.offAll(() => const DashboardView());
        return;
      } else {
        SignInBinding().dependencies();
        Get.offAll(() => const SignInView());
        return;
      }
    });

    super.onInit();
  }

  // Customize this later
  Scaffold errorView(AsyncSnapshot<Object?> snapshot) {
    return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
  }

  Scaffold waitingView() {
    return Scaffold(
        backgroundColor: AppColors.primaryBackground,
        body: Stack(
          children: [
            const Center(child: AppLogo()),
            Align(
              alignment: Alignment.bottomCenter,
              child: LinearProgressIndicator(
                backgroundColor: AppColors.primary.withOpacity(0.2),
              ),
            )
          ],
        ));
  }
}
