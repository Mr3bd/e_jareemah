import 'package:e_jareemah/App/Modules/Enquire/controllers/enquire_controller.dart';
import 'package:e_jareemah/App/Modules/PDFViewer/pdf_viewer.dart';
import 'package:e_jareemah/App/Services/AuthenticationService/Core/manager.dart';
import 'package:e_jareemah/App/Utilities/Constants/AppStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utilities/Constants/AppColors.dart';

class EnquireView extends GetView<EnquireController> {
  const EnquireView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        title: Text(
          'الاستفسارات',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 32.0,
              ),
              Text(
                'موقع دائرة مكافحة الجرائم الإلكترونية',
                style: Get.textTheme.titleLarge!,
              ),
              const SizedBox(
                height: 12.0,
              ),
              GestureDetector(
                onTap: () async {
                  await appTools.openMap(context, 31.9589948, 35.9173994);
                },
                child: Container(
                  width: Get.width,
                  height: (Get.width - 16.0) * 0.359375,
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius:
                          BorderRadius.circular(AppStyles.borderRadius),
                      image: const DecorationImage(
                          image: AssetImage(
                            'assets/images/location_map.png',
                          ),
                          fit: BoxFit.fitHeight)),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.5),
                        borderRadius:
                            BorderRadius.circular(AppStyles.borderRadius)),
                    child: Center(
                      child: Text(
                        'اضغط للانتقال للموقع',
                        style: Get.textTheme.titleLarge!
                            .copyWith(color: AppColors.white),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 32.0,
              ),
              Text(
                'ماذا أفعل بعد تبليغ الشكوى؟',
                style: Get.textTheme.titleLarge!,
              ),
              const SizedBox(
                height: 12.0,
              ),
              Text(
                'إنتظار الرد من قبل الجهة الأمنيّة',
                style: Get.textTheme.labelLarge!
                    .copyWith(color: AppColors.darkBlue),
              ),
              const SizedBox(
                height: 32.0,
              ),
              Text(
                'قانون الجرائم الإلكترونيّة في الأردن ',
                style: Get.textTheme.titleLarge!,
              ),
              const SizedBox(
                height: 12.0,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(
                      () => const PdfViewer(title: 'القانون', fileName: 'law'));
                },
                child: Text(
                  'اضغط هنا لمعرفة القوانين',
                  style: Get.textTheme.labelLarge!
                      .copyWith(color: AppColors.darkBlue),
                ),
              ),
              const SizedBox(
                height: 32.0,
              ),
              Text(
                'تواصل معنا',
                style: Get.textTheme.headlineSmall!,
              ),
              const SizedBox(
                height: 12.0,
              ),
              IconButton(
                  onPressed: () => appTools
                      .openURL('https://www.facebook.com/cybercrimesjordan'),
                  icon: Image.asset('assets/icons/facebook.png'))
            ],
          ),
        ),
      ).marginSymmetric(horizontal: 16.0),
    );
  }
}
