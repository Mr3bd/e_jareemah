import 'package:e_jareemah/App/Modules/SignIn/controller/manager_signin_controller.dart';
import 'package:get/get.dart';

class ManagerSignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManagerSignInController>(
      () => ManagerSignInController(),
    );
  }
}
