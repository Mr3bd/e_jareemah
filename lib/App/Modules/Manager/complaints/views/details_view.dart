import 'package:e_jareemah/App/Utilities/Constants/AppStyles.dart';
import 'package:e_jareemah/App/Utilities/Widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Services/AuthenticationService/Core/manager.dart';
import '../../../../Utilities/Constants/AppColors.dart';
import '../../../Complaint/widget/complaint_detail_item.dart';
import '../controllers/details_controller.dart';

class ComplaintsDetailsView extends GetView<ComplaintsDetailsController> {
  const ComplaintsDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        title: Text(
          controller.source == 1 ? 'شكوى' : 'إبلاغ',
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 32.0,
              ),
              ComplaintDetailItem(
                  label: controller.source == 1 ? 'رقم الشكوى' : 'رقم الإبلاغ',
                  value: controller.complaint.value.id.toString()),
              Obx(
                () => ComplaintDetailItem(
                    label:
                        controller.source == 1 ? 'نوع الجريمة' : 'التبليغ عن',
                    value: controller.type.value),
              ),
              Obx(
                () => ComplaintDetailItem(
                    label: controller.source == 1
                        ? 'مكان تعرضك لجريمة الإلكترونية'
                        : 'المنصة لتبليغ عن الجريمة الإلكترونية',
                    value: controller.locationType.value == ''
                        ? controller.location.value
                        : '${controller.location.value}, ${controller.locationType.value}'),
              ),
              ComplaintDetailItem(
                  label: 'المُشتَكَى عليه',
                  value: controller.complaint.value.defendant!),
              ComplaintDetailItem(
                  label: controller.source == 1 ? 'وصف الشكوى' : 'وصف الإبلاغ',
                  value: controller.complaint.value.description!),
              const ComplaintDetailItem(
                label: 'مرفقات',
                withBack: false,
              ),
              controller.complaint.value.files!.isNotEmpty
                  ? SizedBox(
                      height: Get.width / 3,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.complaint.value.files!.length,
                          itemBuilder: ((context, index) => GestureDetector(
                                onTap: () => appTools.openImage(
                                    controller.complaint.value.files![index]),
                                child: Container(
                                  width: Get.width * 0.3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          AppStyles.borderRadius),
                                      image: DecorationImage(
                                          image: NetworkImage(controller
                                              .complaint.value.files![index]),
                                          fit: BoxFit.cover)),
                                ).marginSymmetric(horizontal: 8.0),
                              ))),
                    )
                  : Center(
                      child: Text(
                      'لا يوجد مرفقات',
                      style: Get.textTheme.headlineSmall!.copyWith(
                          fontSize: 16.0,
                          color: AppColors.grey.withOpacity(0.7)),
                    )).marginOnly(top: 8.0),
              const SizedBox(height: 32.0),
              Center(
                child: GestureDetector(
                  onTap: () {
                    if (!controller.isLoading.value) {
                      controller.changeComplaintStatus();
                    }
                  },
                  child: Obx(
                    () => CustomButton(
                      color: controller.complaint.value.status == 1
                          ? AppColors.managerColor
                          : AppColors.managerColor.withOpacity(0.5),
                      child: controller.isLoading.value
                          ? const CupertinoActivityIndicator(
                              color: AppColors.white,
                            )
                          : Center(
                              child: Text(
                                controller.complaint.value.status == 1
                                    ? controller.source == 1
                                        ? 'إغلاق الشكوى'
                                        : 'إغلاق الإبلاغ'
                                    : 'فتح التحقيق',
                                style: Get.textTheme.labelLarge!
                                    .copyWith(color: AppColors.white),
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
            ],
          ).marginSymmetric(horizontal: 24.0),
        ),
      ),
    );
  }
}
