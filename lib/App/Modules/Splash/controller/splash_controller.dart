import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Services/AuthenticationService/Core/manager.dart';
import '../../../Utilities/Constants/AppColors.dart';

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
        Duration(seconds: _authmanager.isLogged.value == true ? 1 : 5), () {
      // if (_authmanager.isLogged.value) {
      //   if (_authmanager.autisticPatients.isEmpty) {
      //     ABSurveyBinding().dependencies();
      //     Get.offAll(
      //       () => InstructionsView(),
      //     );
      //     return;
      //   }

      //   DashboardBinding().dependencies();
      //   Get.offAll(() => DashboardView());
      //   return;
      // } else {
      //   SignInBinding().dependencies();
      //   Get.offAll(() => SignInView());
      //   return;
      // }
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
          children: <Widget>[
            Center(
                child: SvgPicture.asset(
              'assets/svg/logo.svg',
              width: Get.width * 0.35,
              height: Get.width * 0.35,
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 45.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'by'.tr,
                      style: Get.textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.w100,
                          color: AppColors.darkGrey.withOpacity(0.4)),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'Abdullrahman & Layan',
                      style: Get.textTheme.headline5!.copyWith(
                          color: AppColors.darkGrey.withOpacity(0.6),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
