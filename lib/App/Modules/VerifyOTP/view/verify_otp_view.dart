import 'package:e_jareemah/App/Services/AuthenticationService/Core/manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../Utilities/Widgets/custom_button.dart';
import '../controller/verify_otp_controller.dart';

class VerifyOTPView extends GetView<VerifyOTPController> {
  final String verificationId;
  const VerifyOTPView({super.key, required this.verificationId});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset(
                        "assets/logo.png",
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Verification",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Enter the OTP send to your phone number",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Pinput(
                      length: 6,
                      showCursor: true,
                      defaultPinTheme: PinTheme(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey.shade100,
                          ),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      controller: controller.otpEditingController,
                      onCompleted: (value) {
                        controller.otpEditingController.text = value;
                      },
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: CustomButton(
                        text: "Verify",
                        onTap: () async {
                          if (controller.otpEditingController.text.isNotEmpty) {
                          await  controller.verifyOtp(
                                 verificationId);
                          } else {
                            appTools.showErrorSnackBar('enterOTP'.tr);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Didn't receive any code?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Resend New Code",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
