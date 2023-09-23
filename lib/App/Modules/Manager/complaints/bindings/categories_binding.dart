import 'package:e_jareemah/App/Modules/Manager/complaints/controllers/categories_controller.dart';
import 'package:get/get.dart';

class ComplaintsCategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComplaintsCategoriesController>(
      () => ComplaintsCategoriesController(),
    );
  }
}
