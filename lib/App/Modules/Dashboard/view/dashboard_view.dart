import 'package:e_jareemah/App/Modules/Enquire/binding/enquire_binging.dart';
import 'package:e_jareemah/App/Modules/Enquire/views/enquire_view.dart';
import 'package:e_jareemah/App/Modules/Security/binding/security_binging.dart';
import 'package:e_jareemah/App/Modules/Security/views/security_view.dart';
import 'package:e_jareemah/App/Utilities/Widgets/Drawer/main_drawer.dart';
import 'package:e_jareemah/App/Utilities/Widgets/app_logo.dart';
import 'package:e_jareemah/App/Utilities/Widgets/home_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utilities/Constants/AppColors.dart';
import '../controller/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
        key: controller.scaffoldState,
        backgroundColor: AppColors.primaryBackground,
        drawer: const MainDrawer(),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/logo_hover.png',
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () => controller
                                .scaffoldState.currentState!
                                .openDrawer(),
                            color: AppColors.grey.withOpacity(0.5),
                            icon: const ImageIcon(AssetImage(
                              'assets/icons/menu.png',
                            )))
                      ],
                    ),
                    const AppLogo(),
                    const SizedBox(
                      height: 64.0,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HomeGridItem(label: 'إبلاغ', icon: 'report'),
                        HomeGridItem(label: 'شكوى', icon: 'complaint'),
                      ],
                    ).marginSymmetric(horizontal: Get.width * 0.13),
                    const SizedBox(
                      height: 28.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HomeGridItem(
                          label: 'الإستفسار',
                          icon: 'enquire',
                          onTap: () {
                            Get.to(() => const EnquireView(),
                                binding: EnquireBinding());
                          },
                        ),
                        HomeGridItem(
                          label: 'حماية',
                          icon: 'security',
                          onTap: () {
                            Get.to(() => const SecurityView(),
                                binding: SecurityBinding());
                          },
                        ),
                      ],
                    ).marginSymmetric(horizontal: Get.width * 0.13),
                  ],
                ),
              ),
            ],
          ).marginOnly(top: data.padding.top * 1),
        ));
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
