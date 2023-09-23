import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../../Models/Main/complaint.dart';
import '../../../../Services/AuthenticationService/Core/manager.dart';

class ComplaintsDetailsController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  Rx<Complaint> complaint = Complaint().obs;
  RxBool isLoading = false.obs;
  RxString type = ''.obs, location = ''.obs, locationType = ''.obs;
  int source = Get.arguments[1];

  @override
  void onInit() {
    complaint.value = Get.arguments[0];
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    await getValues();
    super.onReady();
  }

  Future<void> getValues() async {
    isLoading.value = true;
    FirebaseFirestore.instance
        .collection('crime_types')
        .where('id', isEqualTo: complaint.value.type)
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        type.value = snapshot.docs[0]['name'];
      }
    });
    FirebaseFirestore.instance
        .collection('crime_locations')
        .where('id', isEqualTo: complaint.value.location)
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        location.value = snapshot.docs[0]['name'];
      }
    });

    FirebaseFirestore.instance
        .collection('crime_location_types')
        .where('id', isEqualTo: complaint.value.locationType)
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        locationType.value = snapshot.docs[0]['name'];
      }
    });

    isLoading.value = false;
  }

  Future<void> changeComplaintStatus() async {
    isLoading.value = true;
    int newStatus = complaint.value.status == 1 ? 2 : 1;
    FirebaseFirestore.instance
        .collection(source == 1 ? 'complaints' : 'reports')
        .where('id', isEqualTo: complaint.value.id)
        .limit(1)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        FirebaseFirestore.instance
            .collection(source == 1 ? 'complaints' : 'reports')
            .doc(value.docs[0].id)
            .update({'status': newStatus}).then((value) {
          complaint.update((val) {
            val!.status = newStatus;
          });
          isLoading.value = false;
        }).onError((error, stackTrace) {
          isLoading.value = false;
        });
      } else {
        isLoading.value = false;
      }
    });
  }
}
