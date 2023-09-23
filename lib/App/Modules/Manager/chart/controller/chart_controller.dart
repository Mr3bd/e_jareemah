import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_jareemah/App/Models/Main/complaint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Services/AuthenticationService/Core/manager.dart';

class ChartController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  RxList<Complaint> list = <Complaint>[].obs;
  late Stream<QuerySnapshot> crimeTypesStream;
  RxList<ChartData> chartData = <ChartData>[].obs;
  RxBool isLoading = true.obs, isLoadingChart = true.obs;

  @override
  void onInit() {
    crimeTypesStream = FirebaseFirestore.instance
        .collection('crime_types')
        .orderBy('id')
        .snapshots();

    FirebaseFirestore.instance.collection('complaints').get().then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          list.add(Complaint.fromJson(element.data()));
        }
      }

      isLoading.value = false;
    });

    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  RxInt getLength(int id) {
    return list.where((p0) => p0.type == id).length.obs;
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
