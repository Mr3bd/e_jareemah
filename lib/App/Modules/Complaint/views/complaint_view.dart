import 'package:e_jareemah/App/Modules/Complaint/widget/crime_location_list.dart';
import 'package:e_jareemah/App/Modules/Complaint/widget/crime_types_list.dart';
import 'package:e_jareemah/App/Services/AuthenticationService/Core/manager.dart';
import 'package:e_jareemah/App/Utilities/Constants/AppStyles.dart';
import 'package:e_jareemah/App/Utilities/Widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utilities/Constants/AppColors.dart';
import '../controllers/complaint_controller.dart';

class ComplaintView extends GetView<ComplaintController> {
  const ComplaintView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        title: Text(
          'شكوى',
          style: Get.textTheme.headlineMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: AppColors.transparent,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text('بسم الله الرحمن الرحيم',
                            style: Get.textTheme.titleLarge!.copyWith(
                                color: AppColors.darkBlue,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(
                          height: 24.0,
                        ),
                        Text(
                            'إن تعرّضت لجريمة إلكترونيّة يمكنك التبليغ عنها هنا',
                            style: Get.textTheme.titleLarge!.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                    CrimeTypesList(
                      controller: controller,
                    ),
                    CrimeLocationsList(
                      controller: controller,
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    Text('المُشتَكَى عليه (موقع إلكتروني أو شخص)',
                        style: Get.textTheme.titleMedium!.copyWith(
                            color: AppColors.darkBlue,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(
                      height: 24.0,
                    ),
                    TextFormField(
                        autofocus: false,
                        controller: controller.defendantController.value,
                        keyboardType: TextInputType.text,
                        validator: (value) {},
                        onChanged: (newValue) {
                          controller.defendantController.update((val) {});
                        },
                        onSaved: (newValue) {
                          newValue ??= '';
                          controller.defendantController.value.text = newValue;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          suffixIcon: Obx(
                            () => controller
                                    .defendantController.value.text.isEmpty
                                ? const SizedBox()
                                : InkWell(
                                    onTap: () {
                                      controller.defendantController
                                          .update((val) {});

                                      controller.defendantController.value
                                          .clear();
                                    },
                                    child: const Icon(Icons.cancel),
                                  ),
                          ),
                          fillColor: AppColors.grey.withOpacity(0.1),
                          filled: true,
                          hintText: "الرابط / الاسم الرباعي / رقم الهاتف",
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
                    Text('وصف الشكوى',
                        style: Get.textTheme.titleMedium!.copyWith(
                            color: AppColors.darkBlue,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(
                      height: 24.0,
                    ),
                    TextFormField(
                        autofocus: false,
                        controller: controller.descriptionController.value,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLength: 5000,
                        maxLines: 100,
                        onChanged: (newValue) {
                          controller.descriptionController.update((val) {});
                        },
                        onSaved: (newValue) {
                          newValue ??= '';
                          controller.descriptionController.value.text =
                              newValue;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(8),
                          suffixIcon: Obx(
                            () => controller
                                    .descriptionController.value.text.isEmpty
                                ? const SizedBox()
                                : InkWell(
                                    onTap: () {
                                      controller.descriptionController
                                          .update((val) {});

                                      controller.descriptionController.value
                                          .clear();
                                    },
                                    child: const Icon(Icons.cancel),
                                  ),
                          ),
                          fillColor: AppColors.grey.withOpacity(0.1),
                          filled: true,
                          hintText: "تفاصيل الشكوى",
                          hintStyle: TextStyle(
                            color: AppColors.grey.withOpacity(0.5),
                          ),
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
                    Text('مرفقات',
                        style: Get.textTheme.titleMedium!.copyWith(
                            color: AppColors.darkBlue,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      'إن كنت تملك دليلًا صوريّا على ذلك يرجى ارفاق الصورة أو الملف',
                      style: Get.textTheme.labelLarge!
                          .copyWith(color: AppColors.primary),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Obx(
                      () => controller.attachments.isNotEmpty
                          ? SizedBox(
                              height: Get.width / 3,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.attachments.length,
                                  itemBuilder: ((context, index) => Obx(
                                        () => Container(
                                          width: Get.width * 0.3,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppStyles.borderRadius),
                                              image: DecorationImage(
                                                  image: FileImage(controller
                                                      .attachments[index]),
                                                  fit: BoxFit.cover)),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.black
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppStyles.borderRadius),
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                      onPressed: () {
                                                        controller.attachments
                                                            .removeAt(index);
                                                      },
                                                      icon: const Icon(
                                                        Icons.delete,
                                                        color: AppColors.error,
                                                      )),
                                                  const SizedBox(
                                                    width: 4.0,
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        appTools.openImage(
                                                            controller
                                                                .attachments[
                                                                    index]
                                                                .path);
                                                      },
                                                      icon: const Icon(
                                                        Icons.visibility,
                                                        color: AppColors.white,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ).marginSymmetric(horizontal: 8.0))),
                            )
                          : const SizedBox(),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Center(
                      child: IconButton(
                          onPressed: () => controller.pickImages(),
                          iconSize: 48.0,
                          icon: Image.asset('assets/icons/select_attach.png')),
                    ),
                    const SizedBox(
                      height: 48.0,
                    ),
                    Center(
                      child: Obx(
                        () => CustomButton(
                            text: controller.isLoading.value ? null : 'إرسال',
                            onTap: controller.isLoading.value
                                ? () {}
                                : () => controller.sendComplaint(),
                            child: controller.isLoading.value
                                ? const CupertinoActivityIndicator(
                                    color: AppColors.white,
                                  )
                                : null),
                      ),
                    ),
                    const SizedBox(
                      height: 64.0,
                    ),
                  ],
                ).marginSymmetric(horizontal: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
