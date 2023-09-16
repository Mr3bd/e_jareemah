import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_jareemah/App/Modules/Complaint/controllers/report_controller.dart';
import 'package:e_jareemah/App/Utilities/Constants/AppStyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utilities/Constants/AppColors.dart';

class ReportTypesList extends StatelessWidget {
  final controller;
  const ReportTypesList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 32.0,
        ),
        Text('التبليغ عن',
            style: Get.textTheme.titleMedium!.copyWith(
                color: AppColors.darkBlue, fontWeight: FontWeight.w500)),
        const SizedBox(
          height: 8.0,
        ),
        StreamBuilder<QuerySnapshot>(
          stream: controller.reportTypesStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('error'.tr);
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CupertinoActivityIndicator();
            }
            List<DocumentSnapshot> documents = snapshot.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot document = documents[index];

                return GestureDetector(
                  onTap: () {
                    if (controller.crimeType.value != document['id']) {
                      controller.crimeType.value = document['id'];
                    } else {
                      controller.crimeType.value = (-1);
                    }
                  },
                  child: Row(
                    children: [
                      Obx(() => Container(
                            alignment: Alignment.center,
                            width: 22.0,
                            height: 22.0,
                            decoration: BoxDecoration(
                                color:
                                    controller.crimeType.value == document['id']
                                        ? AppColors.primary
                                        : AppColors.transparent,
                                borderRadius: BorderRadius.circular(
                                    AppStyles.borderRadius / 2),
                                border: Border.all(
                                    width: 2.0,
                                    color: controller.crimeType.value ==
                                            document['id']
                                        ? AppColors.primary
                                        : AppColors.darkBlue.withOpacity(0.6))),
                            child: controller.crimeType.value == document['id']
                                ? const FittedBox(
                                    child: Icon(
                                    Icons.done,
                                    color: AppColors.white,
                                  ))
                                : const SizedBox(),
                          )),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        document['name'],
                        style: Get.textTheme.labelLarge!
                            .copyWith(color: AppColors.primary),
                      )
                    ],
                  ),
                ).marginOnly(bottom: 8.0);
              },
            );
          },
        )
      ],
    );
  }
}
