import 'dart:async';
import 'package:e_jareemah/App/Models/Main/DTO/check_url.dart';
import 'package:e_jareemah/App/Models/Main/Response/check_url_response.dart';
import 'package:e_jareemah/App/Modules/Security/provider/security_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Services/AuthenticationService/Core/manager.dart';

class SecurityController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  final Rx<TextEditingController> urlController = TextEditingController().obs;
  Rx<CheckURLDTO> checkURLDTO = CheckURLDTO().obs;
  RxBool isLoading = false.obs;
  Rx<CheckURLResponse> checkURLResponse = CheckURLResponse().obs;
  @override
  void onInit() {
    checkURLDTO.value = CheckURLDTO(
        client: Client(clientId: 'ejareemah', clientVersion: '1.8.2'),
        threatInfo: ThreatInfo(
          threatTypes: [
            "MALWARE",
            "SOCIAL_ENGINEERING",
            "THREAT_TYPE_UNSPECIFIED",
            "UNWANTED_SOFTWARE",
            "POTENTIALLY_HARMFUL_APPLICATION"
          ],
          platformTypes: ["ALL_PLATFORMS"],
          threatEntryTypes: ["URL"],
        ));
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  Future<void> checkURL() async {
    appTools.unFocusKeyboard(Get.context!);
    checkURLDTO.value.threatInfo!.threatEntries = null;
    if (urlController.value.text.isEmpty) {
      appTools.showErrorSnackBar('enterURL'.tr);
      return;
    }
    if (urlController.value.text.isURL) {
      checkURLDTO.value.threatInfo!.threatEntries = [
        ThreatEntries(url: urlController.value.text)
      ];

      checkURLResponse.value = CheckURLResponse();
      isLoading.value = true;
      await SecurityProvider().checkURL(
          onSuccess: (checkURLResponseSec) {
            if (checkURLResponseSec.matches != null) {
              if (checkURLResponseSec.matches!.isNotEmpty) {
                checkURLResponse.value = checkURLResponseSec;
              }
            }
          },
          onError: (error) {},
          checkURLDTO: checkURLDTO.value);

      isLoading.value = false;
    } else {
      appTools.showErrorSnackBar('enterValidURL'.tr);
      return;
    }
  }

  @override
  void onClose() {
    urlController.value.dispose();
    super.onClose();
  }
}
