import 'package:get/get.dart';

import '../controllers/enquire_controller.dart';


class EnquireBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EnquireController>(
      () => EnquireController(),
    );
  }
}
