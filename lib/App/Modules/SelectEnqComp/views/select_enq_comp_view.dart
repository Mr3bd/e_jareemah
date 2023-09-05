import 'package:e_jareemah/App/Modules/Complaint/binding/complaint_binging.dart';
import 'package:e_jareemah/App/Modules/Complaint/views/complaint_view.dart';
import 'package:e_jareemah/App/Utilities/Widgets/select_service_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utilities/Constants/AppColors.dart';
import '../../Complaint/binding/enquire_complaint_binding.dart';
import '../../Complaint/views/enquire_complaint_view.dart';
import '../controllers/select_enq_comp_controller.dart';

class SelectEnqCompView extends GetView<SelectEnqCompController> {
  const SelectEnqCompView({super.key});

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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 64.0,
                    ),
                    SelectServiceItem(
                      icon: 'report',
                      label: 'شكوى',
                      onTap: () {
                        Get.to(() => const ComplaintView(),
                            binding: ComplaintBinding());
                      },
                    ),
                    SelectServiceItem(
                      icon: 'complaint',
                      label: 'إستعلام',
                      onTap: () {
                        Get.to(() => const EnquireComplaintView(),
                            binding: EnquireComplaintBinding());
                      },
                    ),
                  ],
                ).marginSymmetric(horizontal: 24.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
