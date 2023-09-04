import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utilities/Constants/AppColors.dart';
import '../controller/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.primary),
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 2.0,
        titleTextStyle:
            Get.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
      ),
      drawer: Drawer(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [],
        ),
      ),
      body: Center(
        child: Text(controller.authManager.appUser.value.name!),
      ),
    );
  }
}

/*
Obx(
                () => AvatarGlow(
                  animate: controller.isListening.value,
                  glowColor: Theme.of(context).primaryColor,
                  endRadius: 0.0,
                  duration: const Duration(milliseconds: 2000),
                  repeatPauseDuration: const Duration(milliseconds: 100),
                  repeat: true,
                  child: FloatingActionButton(
                      onPressed: controller.listen,
                      child: SvgPicture.asset('assets/svg/microphone.svg')),
                ),

*/
