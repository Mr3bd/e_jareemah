import 'package:e_jareemah/App/Modules/Complaint/controllers/complaint_details_controller.dart';
import 'package:e_jareemah/App/Modules/Complaint/widget/complaint_detail_item.dart';
import 'package:e_jareemah/App/Services/AuthenticationService/Core/manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utilities/Constants/AppColors.dart';
import '../../../Utilities/Constants/AppStyles.dart';

class ComplaintDetailsView extends GetView<ComplaintDetailsController> {
  const ComplaintDetailsView({super.key});

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
                  label: 'رقم الشكوى',
                  value: controller.complaint.id.toString()),
              Obx(
                () => ComplaintDetailItem(
                    label: 'نوع الجريمة', value: controller.type.value),
              ),
              Obx(
                () => ComplaintDetailItem(
                    label: 'مكان تعرضك لجريمة الإلكترونية',
                    value: controller.locationType.value == ''
                        ? controller.location.value
                        : '${controller.location.value}, ${controller.locationType.value}'),
              ),
              ComplaintDetailItem(
                  label: 'المُشتَكَى عليه',
                  value: controller.complaint.defendant!),
              ComplaintDetailItem(
                  label: 'وصف الشكوى',
                  value: controller.complaint.description!),
              const ComplaintDetailItem(
                label: 'مرفقات',
                withBack: false,
              ),
              controller.complaint.files!.isNotEmpty
                  ? SizedBox(
                      height: Get.width / 3,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.complaint.files!.length,
                          itemBuilder: ((context, index) => GestureDetector(
                                onTap: () => appTools.openImage(
                                    controller.complaint.files![index]),
                                child: Container(
                                  width: Get.width * 0.3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          AppStyles.borderRadius),
                                      image: DecorationImage(
                                          image: NetworkImage(controller
                                              .complaint.files![index]),
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
            ],
          ).marginSymmetric(horizontal: 24.0),
        ),
      ),
    );
  }
}
