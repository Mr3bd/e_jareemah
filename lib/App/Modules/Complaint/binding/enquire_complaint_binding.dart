import 'package:e_jareemah/App/Modules/Complaint/controllers/enquire_complaint_controller.dart';
import 'package:get/get.dart';

class EnquireComplaintBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EnquireComplaintController>(
      () => EnquireComplaintController(),
    );
  }
}
