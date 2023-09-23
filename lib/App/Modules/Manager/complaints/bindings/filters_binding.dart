import 'package:get/get.dart';
import '../controllers/filters_controller.dart';

class ComplaintsFiltersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComplaintsFiltersController>(
      () => ComplaintsFiltersController(),
    );
  }
}
