import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../Models/Main/complaint.dart';
import '../../../Services/AuthenticationService/Core/manager.dart';

class ComplaintDetailsController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  final Complaint complaint = Get.arguments;
  RxBool isLoading = false.obs;
  RxString type = ''.obs, location = ''.obs, locationType = ''.obs;

  @override
  Future<void> onReady() async {
    await getValues();
    super.onReady();
  }

  Future<void> getValues() async {
    isLoading.value = true;
    FirebaseFirestore.instance
        .collection('crime_types')
        .where('id', isEqualTo: complaint.type)
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        type.value = snapshot.docs[0]['name'];
      }
    });
    FirebaseFirestore.instance
        .collection('crime_locations')
        .where('id', isEqualTo: complaint.location)
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        location.value = snapshot.docs[0]['name'];
      }
    });

    FirebaseFirestore.instance
        .collection('crime_location_types')
        .where('id', isEqualTo: complaint.locationType)
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        locationType.value = snapshot.docs[0]['name'];
      }
    });
  }
}
