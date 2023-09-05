import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utilities/Constants/AppColors.dart';
import '../../../Utilities/Constants/AppStyles.dart';
import '../controllers/complaint_controller.dart';

class CrimeLocationsList extends GetView<ComplaintController> {
  const CrimeLocationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 32.0,
        ),
        Text('مكان تعرضك لجريمة الإلكترونية',
            style: Get.textTheme.titleMedium!.copyWith(
                color: AppColors.darkBlue, fontWeight: FontWeight.w500)),
        const SizedBox(
          height: 8.0,
        ),
        StreamBuilder<QuerySnapshot>(
          stream: controller.crimeLocationsStream,
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
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (controller.crimeLocation.value != document['id']) {
                          controller.crimeLocation.value = document['id'];
                        } else {
                          controller.crimeLocation.value = (-1);
                        }

                        controller.crimeLocationType.value = (-1);
                      },
                      child: Row(
                        children: [
                          Obx(() => Container(
                                alignment: Alignment.center,
                                width: 22.0,
                                height: 22.0,
                                decoration: BoxDecoration(
                                    color: controller.crimeLocation.value ==
                                            document['id']
                                        ? AppColors.primary
                                        : AppColors.transparent,
                                    borderRadius: BorderRadius.circular(
                                        AppStyles.borderRadius / 2),
                                    border: Border.all(
                                        width: 2.0,
                                        color: controller.crimeLocation.value ==
                                                document['id']
                                            ? AppColors.primary
                                            : AppColors.darkBlue
                                                .withOpacity(0.6))),
                                child: controller.crimeLocation.value ==
                                        document['id']
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
                    ).marginOnly(bottom: 8.0),
                    Obx(
                      () => ((controller.crimeLocation.value ==
                                  document['id']) &&
                              document['id'] != 3)
                          ? StreamBuilder<QuerySnapshot>(
                              stream: controller
                                  .getCrimeTypesStream(document['id']),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                  // return Text('error'.tr);
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CupertinoActivityIndicator();
                                }
                                List<DocumentSnapshot> docs =
                                    snapshot.data!.docs;
                                return ListView.builder(
                                  itemCount: docs.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    DocumentSnapshot doc = docs[index];
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (controller
                                                    .crimeLocationType.value !=
                                                doc['id']) {
                                              controller.crimeLocationType
                                                  .value = doc['id'];
                                            } else {
                                              controller.crimeLocationType
                                                  .value = (-1);
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              Obx(() => Container(
                                                    alignment: Alignment.center,
                                                    width: 22.0,
                                                    height: 22.0,
                                                    decoration: BoxDecoration(
                                                        color: controller
                                                                    .crimeLocationType
                                                                    .value ==
                                                                doc['id']
                                                            ? AppColors.primary
                                                            : AppColors
                                                                .transparent,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                AppStyles.borderRadius /
                                                                    2),
                                                        border: Border.all(
                                                            width: 2.0,
                                                            color: controller
                                                                        .crimeLocationType
                                                                        .value ==
                                                                    doc['id']
                                                                ? AppColors
                                                                    .primary
                                                                : AppColors
                                                                    .darkBlue
                                                                    .withOpacity(0.6))),
                                                    child: controller
                                                                .crimeLocationType
                                                                .value ==
                                                            doc['id']
                                                        ? const FittedBox(
                                                            child: Icon(
                                                            Icons.done,
                                                            color:
                                                                AppColors.white,
                                                          ))
                                                        : const SizedBox(),
                                                  )),
                                              const SizedBox(
                                                width: 8.0,
                                              ),
                                              Text(
                                                doc['name'],
                                                style: Get.textTheme.labelLarge!
                                                    .copyWith(
                                                        color:
                                                            AppColors.primary),
                                              )
                                            ],
                                          ),
                                        ).marginOnly(bottom: 8.0),
                                      ],
                                    );
                                  },
                                );
                              },
                            )
                          : const SizedBox(),
                    ).marginSymmetric(horizontal: 20.0)
                  ],
                ).marginOnly(bottom: 8.0);
              },
            );
          },
        )
      ],
    );
  }
}
