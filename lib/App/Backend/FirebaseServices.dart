import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_jareemah/App/Models/Main/complaint.dart';
import 'package:e_jareemah/App/Models/Main/DTO/register_dto.dart';
import 'package:e_jareemah/App/Models/Main/user_model.dart';
import 'package:e_jareemah/App/Modules/SignIn/controller/signin_controller.dart';
import 'package:e_jareemah/App/Modules/SignUp/controller/sign_up_controller.dart';
import 'package:e_jareemah/App/Modules/VerifyOTP/controller/verify_otp_controller.dart';
import 'package:e_jareemah/App/Modules/VerifyOTP/view/verify_otp_view.dart';
import 'package:e_jareemah/App/Services/AuthenticationService/Core/manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../Modules/VerifyOTP/binding/verify_otp_binding.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

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
    print(userModel.toJson());
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

  Future<String?> getEmail(String password) async {
    String? email;
    await _firebaseFirestore
        .collection('users')
        .where('password', isEqualTo: password)
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        UserModel user = UserModel.fromJson(snapshot.docs[0].data());
        email = user.email;
      }
    });

    return email;
  }

  Future<String> uploadSingleFile(File image) async {
    firebase_storage.Reference storageReference =
        firebase_storage.FirebaseStorage.instance.ref().child(
            'Evidence/${DateTime.now().millisecondsSinceEpoch}_${image.path.split('/').last}');
    firebase_storage.UploadTask uploadTask = storageReference.putFile(image);

    try {
      firebase_storage.TaskSnapshot snapshotTask = await uploadTask;
      String url = await snapshotTask.ref.getDownloadURL();

      return url;
    } on firebase_core.FirebaseException catch (e) {
      if (e.code == 'permission-denied') {}

      return '';
    }
  }

  Future<bool> addComplaint({
    required Complaint complaintDTO,
  }) async {
    bool result = false;
    await _firebaseFirestore
        .collection("complaints")
        .add(complaintDTO.toJson())
        .then((value) {
      result = true;
    });

    return result;
  }

  Future<bool> addReport({
    required Complaint complaintDTO,
  }) async {
    bool result = false;
    await _firebaseFirestore
        .collection("reports")
        .add(complaintDTO.toJson())
        .then((value) {
      result = true;
    });

    return result;
  }

  Future<bool> loginUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    bool result = false;
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (_firebaseAuth.currentUser != null) {
        UserModel userModel =
            await getDataFromFireStore(uid: _firebaseAuth.currentUser!.uid);
        final AuthenticationManager authenticationManager = Get.find();

        if (userModel.userId != null) {
          authenticationManager.login(userModel);
          result = true;
        } else {
          authenticationManager.logOut();
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
    return result;
  }

  Future userSignOut() async {
    await _firebaseAuth.signOut();
  }
}
