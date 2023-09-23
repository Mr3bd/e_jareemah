import 'package:get/get.dart';
import '../controllers/details_controller.dart';

class ComplaintsDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComplaintsDetailsController>(
      () => ComplaintsDetailsController(),
    );
  }
}
