import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../Backend/FirebaseServices.dart';
import '../../../Models/Main/UserModel.dart';
import '../../../Utilities/Methods/tools.dart';
import 'cache.dart';

final AppTools appTools = AppTools();

class AuthenticationManager extends GetxController with CacheManager {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Rx<User?>? appUser;
  Rx<UserModel> appUserData = UserModel().obs;
  final FirebaseServices firebaseServices = FirebaseServices();
  final isLogged = false.obs;
  final GetStorage storage = GetStorage();

  Future<void> logOut() async {
    isLogged.value = false;
    // await storage.erase();
    //appUser!.value = AppUser();
    await firebaseAuth.signOut();
    removeToken();
  }

  void login(String? token) async {
    isLogged.value = true;
    await saveToken(token);
  }

  Future<void> checkLoginStatus() async {
    // logOut();
    appUser = firebaseAuth.currentUser.obs;
    if (appUser!.value != null) {
      isLogged.value = true;
      await firebaseFirestore
          .collection('Users')
          .doc(appUser!.value!.uid)
          .get()
          .then((value) {
        appUserData.value = UserModel.fromJson(value.data()!);
      });
    }
  }
}
