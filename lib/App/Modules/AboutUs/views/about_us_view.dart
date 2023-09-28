import 'package:e_jareemah/App/Services/AuthenticationService/Core/manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../Utilities/Constants/AppColors.dart';
import '../../../Utilities/Widgets/custom_button.dart';
import '../controllers/about_us_controller.dart';

class AboutUsView extends GetView<AboutUsController> {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        title: Text(
          'من نحن',
          style: Get.textTheme.headlineMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: AppColors.primaryBackground,
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
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
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
                  child: SizedBox(
                    width: Get.width * 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'طالبين من جامعة الأميرة سميّة للتكنولوجيا\n\nهدفنا تسليط الضوء على قضيّة الجرائم الإلكترونيّة نظرًا لتفاقم هذه الآفة في عصرنا والتي تودي بحياة المواطنين للخطر.\n\nقمنا بلاقاءات عدّة بالاتفاق مع مشرفنا الأكاديمي ووحدة مكافحة الجرائم الإلكترونيّة وعرض الفكرة عليهم لإيجاد الحلول لهذه المشكلة.',
                          style: Get.textTheme.headlineSmall!.copyWith(
                              color: controller.authManager.isManager
                                  ? AppColors.managerColor
                                  : AppColors.darkBlue,
                              height: 1.5),
                        ),
                        Text(
                          '\nبفضل اللّه تمّ تصميم التطبيق وتلبية طلبات ئيس قسم مكافحة الجرائم الإلكترونيّة بتطويره بالطريقة التي يستفيد منها المواطنين والأمن العام.',
                          style: Get.textTheme.headlineSmall!.copyWith(
                              color: controller.authManager.isManager
                                  ? AppColors.managerColor
                                  : AppColors.darkBlue,
                              height: 1.5),
                        ),
                        Text(
                          '\nمصممي التطبيق:\nعبدالرحمن وصفي الحوامده\nليان ثائر الحمصي',
                          textAlign: TextAlign.start,
                          style: Get.textTheme.headlineSmall!.copyWith(
                              color: controller.authManager.isManager
                                  ? AppColors.managerColor
                                  : AppColors.darkBlue,
                              height: 1.5),
                        ),
                        const SizedBox(
                          height: 32.0,
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ).marginSymmetric(horizontal: 16.0),
    );
  }
}
