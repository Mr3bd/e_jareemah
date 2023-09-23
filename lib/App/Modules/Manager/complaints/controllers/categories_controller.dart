import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../../Services/AuthenticationService/Core/manager.dart';

class ComplaintsCategoriesController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  late Stream<QuerySnapshot> crimeTypesStream;

  @override
  void onInit() {
    crimeTypesStream = FirebaseFirestore.instance
        .collection('crime_types')
        .orderBy('id')
        .snapshots();

    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }
}
