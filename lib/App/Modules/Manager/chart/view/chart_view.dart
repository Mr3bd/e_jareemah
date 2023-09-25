import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_jareemah/App/Modules/Manager/chart/controller/chart_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import '../../../../Models/Main/complaint_cat.dart';
import '../../../../Utilities/Constants/AppColors.dart';
import '../../../../Utilities/Constants/AppStyles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../Utilities/Methods/app_extensions.dart';

class ChartView extends GetView<ChartController> {
  const ChartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        title: Text(
          'إحصائيّات',
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
          child: Column(
            children: [
              Obx(
                () => controller.isLoadingChart.value
                    ? const CupertinoActivityIndicator()
                    : SfCircularChart(series: <CircularSeries>[
                        PieSeries<ChartData, String>(
                          dataSource: controller.chartData,
                          pointColorMapper: (ChartData data, _) => data.color,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          dataLabelMapper: (ChartData data, _) =>
                              data.y == 0.0 ? null : data.x,
                          dataLabelSettings: const DataLabelSettings(
                              isVisible: true, showZeroValue: false),
                        )
                      ]),
              ),
              Obx(
                () => controller.isLoading.value
                    ? const CupertinoActivityIndicator()
                    : StreamBuilder<QuerySnapshot>(
                        stream: controller.crimeTypesStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          controller.chartData.clear();
                          if (snapshot.hasError) {
                            return Text('error'.tr);
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CupertinoActivityIndicator();
                          }

                          if (snapshot.data!.docs.isEmpty) {
                            return Center(
                                child: Text(
                              'لا يوجد تصنيفات',
                              style: Get.textTheme.headlineMedium!
                                  .copyWith(color: AppColors.darkBlue),
                            )).marginOnly(top: 64.0);
                          }
                          List<DocumentSnapshot> documents =
                              snapshot.data!.docs;
                          return ListView.builder(
                            itemCount: documents.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              ComplaintCat cat = ComplaintCat.fromJson(
                                  documents[index].data()
                                      as Map<String, dynamic>);
                              int length = controller.getLength(cat.id!).value;
                              controller.chartData.add(ChartData(cat.name ?? '',
                                  length.toDouble(), cat.color!.toColor()));
                              print(index == (documents.length - 1));
                              if (index == (documents.length - 1)) {
                                SchedulerBinding.instance
                                    .addPostFrameCallback((_) {
                                  controller.isLoadingChart.value = false;
                                });

                                print('yes');
                              }
                              return Row(
                                children: [
                                  Container(
                                    width: 32.0,
                                    height: 32.0,
                                    margin: const EdgeInsets.only(bottom: 8.0),
                                    decoration: BoxDecoration(
                                        color:
                                            controller.chartData[index].color,
                                        borderRadius: BorderRadius.circular(
                                            AppStyles.borderRadius)),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    cat.name ?? '',
                                    style: Get.textTheme.titleMedium!.copyWith(
                                        color: AppColors.darkBlue,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    width: 4.0,
                                  ),
                                  Text(
                                    '($length)',
                                    style: Get.textTheme.titleMedium!.copyWith(
                                        color: AppColors.darkBlue,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
              )
            ],
          ),
        ).marginSymmetric(horizontal: 20.0, vertical: 16.0),
      ),
    );
  }
}
