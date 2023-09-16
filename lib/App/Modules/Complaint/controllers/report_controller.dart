import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_jareemah/App/Models/Main/complaint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Services/AuthenticationService/Core/manager.dart';
import '../../../Services/PermissionService/permission_handler_service.dart';

class ReportController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  final Rx<TextEditingController> defendantController =
          TextEditingController().obs,
      descriptionController = TextEditingController().obs;
  late Stream<QuerySnapshot> reportTypesStream, crimeLocationsStream;
  RxInt crimeType = (-1).obs,
      crimeLocation = (-1).obs,
      crimeLocationType = (-1).obs;
  RxList<File> attachments = <File>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    reportTypesStream = FirebaseFirestore.instance
        .collection('report_types')
        .orderBy('id')
        .snapshots();
    crimeLocationsStream = FirebaseFirestore.instance
        .collection('crime_locations')
        .orderBy('id')
        .snapshots();
    super.onInit();
  }

  Future<void> pickImages() async {
    if (attachments.length < 6) {
      bool per = await HandlerPermissionService().handlePhotosPermission();
      if (per) {
        ImagePicker picker = ImagePicker();
        XFile? file = await picker.pickImage(
            source: ImageSource.gallery, imageQuality: 35);
        if (file != null) {
          attachments.add(File(file.path));
        }
      }
    } else {
      appTools.showErrorSnackBar('الحد الأقصى 6 صور');
    }
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCrimeTypesStream(
      int location) {
    return FirebaseFirestore.instance
        .collection('crime_location_types')
        .where('location', isEqualTo: location)
        .orderBy('id')
        .snapshots();
  }

  Future<void> sendReport() async {
    if (crimeType.value < 0) {
      return appTools.showErrorSnackBar('يرجى اختيار نوع الإبلاغ');
    } else if (crimeLocation.value < 0) {
      return appTools.showErrorSnackBar('يرجى اختيار موقع الإبلاغ');
    } else if (crimeType.value < 0) {
      return appTools
          .showErrorSnackBar('يرجى تحديد موقع الإبلاغ بشكل دقيق من الاختيارات');
    } else if (defendantController.value.text.isEmpty) {
      return appTools.showErrorSnackBar('يرجى ادخال المشتكى عليه');
    } else if (descriptionController.value.text.isEmpty) {
      return appTools.showErrorSnackBar('يرجى ادخال وصف للإبلاغ');
    }
    isLoading.value = true;
    Complaint complaintDTO = Complaint(
        id: appTools.createRandom(),
        status: 1,
        nId: authManager.appUser.value.nId,
        type: crimeType.value,
        location: crimeLocation.value,
        locationType: crimeLocationType.value,
        defendant: defendantController.value.text,
        description: descriptionController.value.text,
        date: DateTime.now().toString());
    if (attachments.isNotEmpty) {
      List<String> urls = [];
      for (var element in attachments) {
        String link =
            await authManager.firebaseServices.uploadSingleFile(element);
        if (link.isNotEmpty) {
          urls.add(link);
        }
      }

      if (urls.length == attachments.length) {
        complaintDTO.files = [];
        complaintDTO.files!.addAll(urls);
      } else {
        isLoading.value = false;
        return appTools.showErrorSnackBar('error'.tr);
      }
    }

    bool result = await authManager.firebaseServices
        .addReport(complaintDTO: complaintDTO);

    if (result) {
      isLoading.value = false;
      Get.back();
      return appTools.showSuccessSnackBar('لقد تم ارسال الإبلاغ بنجاح');
    } else {
      isLoading.value = false;
      return appTools.showErrorSnackBar('error'.tr);
    }
  }

  @override
  void onClose() {
    defendantController.value.dispose();
    descriptionController.value.dispose();
    super.onClose();
  }
}
