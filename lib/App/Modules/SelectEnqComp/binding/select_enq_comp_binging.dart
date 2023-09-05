import 'package:get/get.dart';
import '../controllers/select_enq_comp_controller.dart';

class SelectEnqCompBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectEnqCompController>(
      () => SelectEnqCompController(),
    );
  }
}
