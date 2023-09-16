import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Constants/AppColors.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final Color? color;
  final Function()? onTap;

  const CustomButton({super.key, this.text, this.child, this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.6,
      height: Get.width * 0.1,
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(8.0),
        color: color ?? AppColors.primary,
        child: child ??
            MaterialButton(
                padding: const EdgeInsets.all(4.0),
                minWidth: MediaQuery.of(context).size.width,
                onPressed: onTap,
                child: Text(
                  text ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
      ),
    );
  }
}
