import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_jareemah/App/Models/Main/DTO/register_dto.dart';
import 'package:e_jareemah/App/Models/Main/user_model.dart';
import 'package:e_jareemah/App/Modules/SignIn/controller/signin_controller.dart';
import 'package:e_jareemah/App/Modules/SignUp/controller/sign_up_controller.dart';
import 'package:e_jareemah/App/Modules/VerifyOTP/controller/verify_otp_controller.dart';
import 'package:e_jareemah/App/Modules/VerifyOTP/view/verify_otp_view.dart';
import 'package:e_jareemah/App/Services/AuthenticationService/Core/manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../Modules/VerifyOTP/binding/verify_otp_binding.dart';

class FirebaseServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  // final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<void> signInWithPhone(RegisterDTO registerDTO, bool register) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: registerDTO.phone,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
            if (register) {
              final SignUpController signUpController = Get.find();
              signUpController.isLoading.value = false;
            } else {
              final SignInController signInController = Get.find();
              signInController.isLoading.value = false;
            }
          },
          verificationFailed: (error) {
            if (register) {
              final SignUpController signUpController = Get.find();
              signUpController.isLoading.value = false;
              appTools.showErrorSnackBar('registerFailed'.tr);
            } else {
              final SignInController signInController = Get.find();
              signInController.isLoading.value = false;
              appTools.showErrorSnackBar('loginFailed'.tr);
            }

            // throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            if (register) {
              final SignUpController signUpController = Get.find();
              signUpController.isLoading.value = false;
            } else {
              final SignInController signInController = Get.find();
              signInController.isLoading.value = false;
            }
            Get.to(
              () => VerifyOTPView(verificationId: verificationId),
              binding: VerifyOTPBinding(),
              arguments: register,
            );
          },
          codeAutoRetrievalTimeout: (verficationId) {});
    } on FirebaseAuthException catch (e) {
      if (register) {
        final SignUpController signUpController = Get.find();
        signUpController.isLoading.value = false;
        appTools.showErrorSnackBar('registerFailed'.tr);
      } else {
        final SignInController signInController = Get.find();
        signInController.isLoading.value = false;
        appTools.showErrorSnackBar('loginFailed'.tr);
      }
    }
  }

  Future<void> verifyOtp({
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      User? user = (await _firebaseAuth.signInWithCredential(creds)).user!;

      onSuccess(user);
    } on FirebaseAuthException catch (e) {
      final VerifyOTPController verifyOTPController = Get.find();
      verifyOTPController.isLoading.value = false;
      appTools.showErrorSnackBar('registerFailed'.tr);
    }
  }

  Future<bool> checkExistingUser(UserModel userModel) async {
    bool exist = false;

    await _firebaseFirestore
        .collection('users')
        .where('nId', isEqualTo: userModel.nId)
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        exist = true;
        return;
      }
    });

    await _firebaseFirestore
        .collection('users')
        .where('phone', isEqualTo: userModel.phone)
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        exist = true;
      }
    });
    return exist;
  }

  Future<UserModel> getDataFromFireStore({String? uid}) async {
    UserModel userModel = UserModel();
    await _firebaseFirestore
        .collection("users")
        .doc(uid ?? _firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      userModel = UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
    });

    return userModel;
  }

  Future<bool> saveUserDataToFirebase({
    required UserModel userModel,
  }) async {
    bool result = false;
    await _firebaseFirestore
        .collection("users")
        .doc(userModel.userId)
        .set(userModel.toJson())
        .then((value) {
      result = true;
    });

    return result;
  }

  Future<String?> getUserPhone(String nId, String password) async {
    String? phone;
    await _firebaseFirestore
        .collection('users')
        .where('nId', isEqualTo: nId)
        .where('password', isEqualTo: password)
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        UserModel user = UserModel.fromJson(snapshot.docs[0].data());
        phone = user.phone;
      }
    });

    return phone;
  }

  Future userSignOut() async {
    await _firebaseAuth.signOut();
  }
}
