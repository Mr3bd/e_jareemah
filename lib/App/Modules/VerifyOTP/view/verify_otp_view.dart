import 'package:e_jareemah/App/Modules/SignIn/controller/signin_controller.dart';
import 'package:e_jareemah/App/Modules/SignUp/controller/sign_up_controller.dart';
import 'package:e_jareemah/App/Services/AuthenticationService/Core/manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../Utilities/Constants/AppColors.dart';
import '../../../Utilities/Widgets/custom_button.dart';
import '../controller/verify_otp_controller.dart';

class VerifyOTPView extends GetView<VerifyOTPController> {
  final String verificationId;
  const VerifyOTPView({
    super.key,
    required this.verificationId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
            if (controller.register) {
              final SignUpController signUpController = Get.find();
              signUpController.isLoading.value = false;
            } else {
              final SignInController signInController = Get.find();
              signInController.isLoading.value = false;
            }
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: Get.height * 0.05),
            Text(
              'أدخل الرقم المُرسَل على ال SMS',
              style: Get.textTheme.headlineSmall!
                  .copyWith(color: AppColors.darkBlue),
            ),
            SizedBox(height: Get.height * 0.1),
            Image.asset(
              'assets/icons/sms.png',
              color: AppColors.primary,
              width: Get.width * 0.25,
            ),
            SizedBox(height: Get.height * 0.1),
            PinFieldAutoFill(
              onCodeChanged: (code) {
                controller.otpCode.value = code!;
              },
              onCodeSubmitted: (v) {
                controller.otp.text = controller.otpCode.value = v;
              },
              codeLength: 6,
              autoFocus: true,
              controller: controller.otp,
              decoration: CirclePinDecoration(
                strokeWidth: 1,
                bgColorBuilder: PinListenColorBuilder(
                    AppColors.primary.withOpacity(0.5), Colors.grey.shade100),
                strokeColorBuilder:
                    FixedColorBuilder(Colors.black.withOpacity(0.2)),
              ),
            ).paddingSymmetric(horizontal: 16),
            const SizedBox(height: 32.0),
            Obx(
              () => CustomButton(
                text: controller.isLoading.value ? null : "تحقق",
                onTap: controller.isLoading.value
                    ? () {}
                    : () async {
                        if (controller.checkIfOtpValid()) {
                          await controller.verifyOtp(verificationId);
                        } else {
                          appTools.showErrorSnackBar('enterValidOTP'.tr);
                        }
                      },
                child: controller.isLoading.value
                    ? const CupertinoActivityIndicator(
                        color: AppColors.white,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
