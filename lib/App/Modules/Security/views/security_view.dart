import 'package:e_jareemah/App/Modules/Security/controllers/security_controller.dart';
import 'package:e_jareemah/App/Services/AuthenticationService/Core/manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../Utilities/Constants/AppColors.dart';
import '../../../Utilities/Widgets/custom_button.dart';

class SecurityView extends GetView<SecurityController> {
  const SecurityView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => appTools.unFocusKeyboard(context),
      child: Scaffold(
        backgroundColor: AppColors.primaryBackground,
        appBar: AppBar(
          title: Text(
            'حماية',
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
          
          actions: [
            InkWell(
             onTap: () =>
                            appTools.showAPI(AppColors.primary),
                        child: Row(
                        
                          children: [
                            
                            Icon(
                              Icons.info_outline,
                              color: Colors.black54,
                              size: 35,
                              
                            ),
                          ],
          ),
            ),
          ],
        ),
        body: Obx(
          () => SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 32.0,
                  ),
                  SvgPicture.asset(
                    'assets/icons/check_link.svg',
                    // scale: 2.5,
                    width: Get.width * 0.3,
                    height: Get.width * 0.3,
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  Text(
                    'تعمل خاصيّة “حماية” على حمايتك من المواقع المشتبه بها قبل دخولها كي لا تقع ضحيّةً لجريمةٍ إلكترونيّة',
                    textAlign: TextAlign.center,
                    style: Get.textTheme.headlineSmall!
                        .copyWith(fontSize: 18.0, color: AppColors.darkBlue),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                 // Row(
                 //   crossAxisAlignment: CrossAxisAlignment.start,
               //     children: [
             //         Image.asset(
                   //     'assets/icons/google.png',
                 //       width: Get.width * 0.1,
               //       ),
             //         const SizedBox(width: 8.0),
           //           Expanded(
         //               child: Text(
                   //       'يتم تقييم الروابط بواسطة جوجل API v4 من خلال البحث في قواعد بيانات خاصة تحتوي على المواقع الخبيثة',
                 //         style: Get.textTheme.labelLarge,
               //         ),
             //         ),
           //         ],
               //   ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  TextFormField(
                      autofocus: false,
                      controller: controller.urlController.value,
                      keyboardType: TextInputType.text,
                      validator: (value) {},
                      onChanged: (newValue) {
                        controller.urlController.update((val) {
                          if (newValue.isEmpty) {
                            controller.checkURLDTO.update((val) {
                              val!.threatInfo!.threatEntries = null;
                            });
                          }
                        });
                      },
                      onSaved: (newValue) {
                        newValue ??= '';
                        controller.urlController.value.text = newValue;
                        if (newValue.isEmpty) {
                          controller.checkURLDTO.update((val) {
                            val!.threatInfo!.threatEntries = null;
                          });
                        }
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.link),
                        suffixIcon: Obx(
                          () => controller.urlController.value.text.isEmpty
                              ? const SizedBox()
                              : InkWell(
                                  onTap: () {
                                    controller.urlController.update((val) {});

                                    controller.urlController.value.clear();
                                    controller.checkURLDTO.update((val) {
                                      val!.threatInfo!.threatEntries = null;
                                    });
                                  },
                                  child: const Icon(Icons.cancel),
                                ),
                        ),
                        fillColor: AppColors.grey.withOpacity(0.1),
                        filled: true,
                        hintText: "الرابط المشتبه به، كمثال: http://www...",
                        hintStyle: TextStyle(
                          color: AppColors.grey.withOpacity(0.5),
                        ),
                        contentPadding: const EdgeInsets.all(8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.primary.withOpacity(0.4),
                              width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColors.transparent, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )),
                  const SizedBox(
                    height: 32.0,
                  ),
                  Obx(
                    () => CustomButton(
                        text: controller.isLoading.value ? null : 'فحص',
                        onTap: controller.isLoading.value
                            ? () {}
                            : () => controller.checkURL(),
                        child: controller.isLoading.value
                            ? const CupertinoActivityIndicator(
                                color: AppColors.white,
                              )
                            : null),
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  Obx(
                    () => controller.checkURLDTO.value.threatInfo!
                                    .threatEntries !=
                                null &&
                            !controller.isLoading.value
                        ? Column(
                            children: [
                              Text(
                                'النتيجة',
                                textAlign: TextAlign.center,
                                style: Get.textTheme.headlineSmall!.copyWith(
                                    fontSize: 18.0, color: AppColors.darkBlue),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                'الموقع: ${controller.checkURLDTO.value.threatInfo!.threatEntries![0].url}',
                                textAlign: TextAlign.center,
                                style: Get.textTheme.labelLarge,
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Column(
                                children: [
                                  controller.checkURLResponse.value.matches ==
                                          null
                                      ? Column(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/secure.svg',
                                              color: AppColors.success,
                                            ),
                                            Text(
                                              'آمن',
                                              textAlign: TextAlign.center,
                                              style: Get.textTheme.labelLarge!
                                                  .copyWith(
                                                      color: AppColors.success),
                                            )
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/unsecure.svg',
                                              color: AppColors.error,
                                            ),
                                            Text(
                                              'غير آمن',
                                              textAlign: TextAlign.center,
                                              style: Get.textTheme.labelLarge!
                                                  .copyWith(
                                                      color: AppColors.error),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
          ).marginSymmetric(horizontal: 16.0),
        ),
      ),
    );
  }
}
