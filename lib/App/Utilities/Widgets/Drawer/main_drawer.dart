import 'package:e_jareemah/App/Modules/AboutUs/binding/about_us_binding.dart';
import 'package:e_jareemah/App/Modules/AboutUs/views/about_us_view.dart';
import 'package:e_jareemah/App/Modules/Dashboard/controller/dashboard_controller.dart';
import 'package:e_jareemah/App/Modules/PDFViewer/pdf_viewer.dart';
import 'package:e_jareemah/App/Modules/SignIn/binding/signin_binding.dart';
import 'package:e_jareemah/App/Modules/SignIn/view/signin_view.dart';
import 'package:e_jareemah/App/Utilities/Widgets/Drawer/drawer_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Modules/Complaint/binding/complaint_binging.dart';
import '../../../Modules/Complaint/binding/enquire_complaint_binding.dart';
import '../../../Modules/Complaint/views/complaint_view.dart';
import '../../../Modules/Complaint/views/enquire_complaint_view.dart';
import '../../../Modules/Enquire/binding/enquire_binging.dart';
import '../../../Modules/Enquire/views/enquire_view.dart';
import '../../../Modules/Security/binding/security_binging.dart';
import '../../../Modules/Security/views/security_view.dart';
import '../../../Modules/SignIn/binding/manager_signin_binding.dart';
import '../../../Modules/SignIn/view/manager_SignIn_view.dart';

class MainDrawer extends GetView<DashboardController> {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);

    return Drawer(
      width: Get.width * 0.65,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: data.padding.top * 2,
            ),
            Image.asset(
              'assets/images/image_profile.png',
              width: Get.width * 0.25,
              height: Get.width * 0.25,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Center(
                child: Text(
              controller.authManager.appUser.value.name!,
              style: Get.textTheme.labelLarge,
            )),
            const SizedBox(
              height: 32.0,
            ),
            !controller.authManager.isManager
                ? Column(
                    children: [
                      DrawerListItem(
                        label: 'شكوى',
                        onTap: () {
                          Get.to(() => const ComplaintView(),
                              binding: ComplaintBinding());
                        },
                      ),
                      DrawerListItem(
                          label: 'إستعلام',
                          onTap: () {
                            Get.to(() => const EnquireComplaintView(),
                                binding: EnquireComplaintBinding());
                          }),
                      DrawerListItem(
                          label: 'القانون',
                          onTap: () {
                            Get.to(() => const PdfViewer(
                                title: 'القانون', fileName: 'law'));
                          }),
                      DrawerListItem(
                          label: 'حماية',
                          onTap: () {
                            Get.to(() => const SecurityView(),
                                binding: SecurityBinding());
                          }),
                      DrawerListItem(
                          label: 'الاستفسار',
                          onTap: () {
                            Get.to(() => const EnquireView(),
                                binding: EnquireBinding());
                          }),
                      DrawerListItem(
                          label: 'من نحن',
                          onTap: () {
                            Get.to(() => const AboutUsView(),
                                binding: AboutUsBinding());
                          }),
                      DrawerListItem(
                          label: 'خروج',
                          onTap: () async {
                            await controller.authManager.logOut();
                            Get.offAll(() => const SignInView(),
                                binding: SignInBinding());
                          }),
                    ],
                  )
                : Column(
                    children: [
                      DrawerListItem(
                          label: 'من نحن',
                          onTap: () {
                            Get.to(() => const AboutUsView(),
                                binding: AboutUsBinding());
                          }),
                      DrawerListItem(
                          label: 'خروج',
                          onTap: () async {
                            await controller.authManager.logOut();
                            Get.off(() => const ManagerSignInView(),
                                binding: ManagerSignInBinding());
                          }),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
