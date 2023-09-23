import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Services/AuthenticationService/Core/manager.dart';

class ComplaintsFiltersController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  int source = Get.arguments[0];
  int catId = Get.arguments[1];

  Rx<Stream<QuerySnapshot>> crimesStream = FirebaseFirestore.instance
      .collection(
        'complaints',
      )
      .orderBy('date')
      .snapshots()
      .obs;
  RxInt status = (-1).obs;
  TextEditingController nationalId = TextEditingController();

  @override
  void onInit() {
    ever(status, (callback) => changeFilter());
    status.value = 0;
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  void changeFilter() {
    if (source == 1) {
      if (status < 1) {
        if (nationalId.text.isNotEmpty) {
          crimesStream.value = FirebaseFirestore.instance
              .collection(
                'complaints',
              )
              .where('type', isEqualTo: catId)
              .where('nId', isEqualTo: nationalId.text)
              .orderBy('date')
              .snapshots();
        } else {
          crimesStream.value = FirebaseFirestore.instance
              .collection(
                'complaints',
              )
              .where('type', isEqualTo: catId)
              .orderBy('date')
              .snapshots();
        }
      } else {
        if (nationalId.text.isNotEmpty) {
          crimesStream.value = FirebaseFirestore.instance
              .collection(
                'complaints',
              )
              .where('type', isEqualTo: catId)
              .where('nId', isEqualTo: nationalId.text)
              .where('status', isEqualTo: status.value)
              .orderBy('date')
              .snapshots();
        } else {
          crimesStream.value = FirebaseFirestore.instance
              .collection(
                'complaints',
              )
              .where('type', isEqualTo: catId)
              .where('status', isEqualTo: status.value)
              .orderBy('date')
              .snapshots();
        }
      }
    } else {
      if (status < 1) {
        if (nationalId.text.isNotEmpty) {
          crimesStream.value = FirebaseFirestore.instance
              .collection(
                'reports',
              )
              .where('nId', isEqualTo: nationalId.text)
              .orderBy('date')
              .snapshots();
        } else {
          crimesStream.value = FirebaseFirestore.instance
              .collection(
                'reports',
              )
              .orderBy('date')
              .snapshots();
        }
      } else {
        if (nationalId.text.isNotEmpty) {
          crimesStream.value = FirebaseFirestore.instance
              .collection(
                'reports',
              )
              .where('nId', isEqualTo: nationalId.text)
              .where('status', isEqualTo: status.value)
              .orderBy('date')
              .snapshots();
        } else {
          crimesStream.value = FirebaseFirestore.instance
              .collection(
                'reports',
              )
              .where('status', isEqualTo: status.value)
              .orderBy('date')
              .snapshots();
        }
      }
    }
  }
}
