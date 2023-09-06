import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../Services/AuthenticationService/Core/manager.dart';

class EnquireComplaintController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  late Stream<QuerySnapshot> getComplaints;

  @override
  Future<void> onInit() async {
    getComplaints = FirebaseFirestore.instance
        .collection(
          'complaints',
        )
        .orderBy('date')
        .where('nId', isEqualTo: authManager.appUser.value.nId)
        .snapshots();
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }
}
