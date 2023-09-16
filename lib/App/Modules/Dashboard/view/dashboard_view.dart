import 'package:e_jareemah/App/Modules/Complaint/binding/report_binging.dart';
import 'package:e_jareemah/App/Modules/Enquire/binding/enquire_binging.dart';
import 'package:e_jareemah/App/Modules/Enquire/views/enquire_view.dart';
import 'package:e_jareemah/App/Modules/Security/binding/security_binging.dart';
import 'package:e_jareemah/App/Modules/Security/views/security_view.dart';
import 'package:e_jareemah/App/Modules/SelectEnqComp/binding/select_enq_comp_binging.dart';
import 'package:e_jareemah/App/Utilities/Widgets/Drawer/main_drawer.dart';
import 'package:e_jareemah/App/Utilities/Widgets/app_logo.dart';
import 'package:e_jareemah/App/Utilities/Widgets/home_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utilities/Constants/AppColors.dart';
import '../../Complaint/views/report_view.dart';
import '../../SelectEnqComp/views/select_enq_comp_view.dart';
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
          physics: const BouncingScrollPhysics(),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HomeGridItem(
                          label: 'شكوى',
                          icon: 'complaint',
                          onTap: () {
                            Get.to(() => const SelectEnqCompView(),
                                binding: SelectEnqCompBinding());
                          },
                        ),
                        HomeGridItem(
                          label: 'إبلاغ',
                          icon: 'report',
                          onTap: () => Get.to(() => const ReportView(),
                              binding: ReportBinding()),
                        ),
                      ],
                    ).marginSymmetric(horizontal: Get.width * 0.15),
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
                    ).marginSymmetric(horizontal: Get.width * 0.15),
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
