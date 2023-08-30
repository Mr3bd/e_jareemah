
import 'package:get/get.dart';

import '../../Modules/SignIn/binding/signin_binding.dart';
import '../../Modules/SignIn/view/signin_view.dart';
import '../../Modules/Splash/binding/splash_binding.dart';
import '../../Modules/Splash/view/splash_view.dart';

part 'routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
        name: Routes.SPLASH,
        page: () => SplashView(),
        binding: SplashBinding()),
    GetPage(
        name: Routes.SIGN_IN,
        page: () => SignInView(),
        binding: SignInBinding()),
   
  ];
}
