import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../Backend/FirebaseServices.dart';
import '../../../Models/Main/user_model.dart';
import '../../../Utilities/Methods/tools.dart';
import 'cache.dart';

final AppTools appTools = AppTools();

class AuthenticationManager extends GetxController with CacheManager {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Rx<UserModel> appUser = UserModel().obs;
  final FirebaseServices firebaseServices = FirebaseServices();
  final isLogged = false.obs;
  final GetStorage storage = GetStorage();

  Future<void> logOut() async {
    isLogged.value = false;
    await storage.erase();
    appUser.value = UserModel();
    await firebaseServices.userSignOut();

    removeToken();
  }

  void login(UserModel value) async {
    isLogged.value = true;
    appUser.value = value;
    await saveToken(value.userId);
  }

  Future<void> checkLoginStatus() async {
    final token = getToken();

    if (token != null) {
      isLogged.value = true;
      UserModel userModel =
          await firebaseServices.getDataFromFireStore(uid: token);
      if (userModel.userId != null) {
        appUser.value = userModel;
      } else {
        logOut();
      }
    } else {
      logOut();
    }
  }
}
