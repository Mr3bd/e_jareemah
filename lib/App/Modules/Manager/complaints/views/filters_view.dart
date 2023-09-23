import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_jareemah/App/Models/Main/complaint.dart';
import 'package:e_jareemah/App/Modules/Manager/complaints/bindings/details_bindings.dart';
import 'package:e_jareemah/App/Modules/Manager/complaints/controllers/filters_controller.dart';
import 'package:e_jareemah/App/Modules/Manager/complaints/views/details_view.dart';
import 'package:e_jareemah/App/Modules/Manager/complaints/widgets/man_complaint_item.dart';
import 'package:e_jareemah/App/Utilities/Constants/AppStyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Utilities/Constants/AppColors.dart';

class ComplaintsFiltersView extends GetView<ComplaintsFiltersController> {
  final String title;
  const ComplaintsFiltersView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        title: Text(
          title,
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
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(AppStyles.borderRadius * 1.5),
                        border:
                            Border.all(color: AppColors.darkGrey, width: 1.0)),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (controller.status.value != 0) {
                                controller.status.value = 0;
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  color: controller.status.value == 0
                                      ? AppColors.managerColor
                                      : AppColors.white,
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(
                                          AppStyles.borderRadius * 1.5),
                                      bottomRight: Radius.circular(
                                          AppStyles.borderRadius * 1.5))),
                              child: Center(
                                child: Text(
                                  'الكل',
                                  style: Get.textTheme.labelMedium!.copyWith(
                                      color: controller.status.value == 0
                                          ? AppColors.white
                                          : null),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (controller.status.value != 1) {
                                controller.status.value = 1;
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: controller.status.value == 1
                                    ? AppColors.managerColor
                                    : AppColors.white,
                              ),
                              child: Center(
                                child: Text(
                                  'قيد التحري',
                                  style: Get.textTheme.labelMedium!.copyWith(
                                      color: controller.status.value == 1
                                          ? AppColors.white
                                          : null),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (controller.status.value != 2) {
                                controller.status.value = 2;
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  color: controller.status.value == 2
                                      ? AppColors.managerColor
                                      : AppColors.white,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(
                                          AppStyles.borderRadius * 1.5),
                                      bottomLeft: Radius.circular(
                                          AppStyles.borderRadius * 1.5))),
                              child: Center(
                                child: Text(
                                  'مغلقة',
                                  style: Get.textTheme.labelMedium!.copyWith(
                                      color: controller.status.value == 2
                                          ? AppColors.white
                                          : null),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  TextFormField(
                      autofocus: false,
                      controller: controller.nationalId,
                      keyboardType: TextInputType.text,
                      validator: (value) {},
                      onChanged: (newValue) {
                        controller.changeFilter();
                      },
                      onSaved: (newValue) {
                        controller.changeFilter();
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        fillColor: AppColors.grey.withOpacity(0.1),
                        filled: true,
                        hintText: "الرقم الوطني",
                        hintStyle: TextStyle(
                          color: AppColors.grey.withOpacity(0.5),
                        ),
                        contentPadding: const EdgeInsets.all(8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.primary.withOpacity(0.4),
                              width: 2),
                          borderRadius: BorderRadius.circular(
                              AppStyles.borderRadius * 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColors.transparent, width: 2),
                          borderRadius: BorderRadius.circular(
                              AppStyles.borderRadius * 2.0),
                        ),
                      )),
                  const SizedBox(
                    height: 24.0,
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: controller.crimesStream.value,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('error'.tr);
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CupertinoActivityIndicator();
                      }

                      if (snapshot.data!.docs.isEmpty) {
                        return Center(
                            child: Text(
                          controller.source == 1
                              ? 'لا يوجد شكاوي'
                              : 'لا يوجد إبلاغات',
                          style: Get.textTheme.headlineMedium!
                              .copyWith(color: AppColors.darkBlue),
                        )).marginOnly(top: 64.0);
                      }
                      List<DocumentSnapshot> documents = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: documents.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          Complaint complaint = Complaint.fromJson(
                              documents[index].data() as Map<String, dynamic>);

                          return ManComplaintItem(
                              date: complaint.date ?? '',
                              number: complaint.id ?? 1,
                              status: complaint.status ?? 1,
                              nId: complaint.nId ?? '',
                              source: controller.source,
                              onTap: () => Get.to(
                                  () => const ComplaintsDetailsView(),
                                  binding: ComplaintsDetailsBinding(),
                                  arguments: [complaint, controller.source]));
                        },
                      );
                    },
                  ),
                ],
              ),
            )).marginSymmetric(horizontal: 20.0, vertical: 16.0),
      ),
    );
  }
}
