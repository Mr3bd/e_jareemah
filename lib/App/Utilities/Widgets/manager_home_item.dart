import 'package:e_jareemah/App/Utilities/Constants/AppStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../Constants/AppColors.dart';

class ManagerHomeItem extends StatelessWidget {
  final String icon, label;
  final Function() onTap;

  const ManagerHomeItem(
      {super.key,
      required this.icon,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width * 0.9,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(width: 6.0, color: AppColors.milky),
            borderRadius: BorderRadius.circular(AppStyles.borderRadius)),
        child: Row(
          children: [
            Image.asset(
              'assets/icons/$icon.png',
              width: 64,
            ),
            const SizedBox(
              width: 12.0,
            ),
            SizedBox(
                width: Get.width * 0.6,
                child: Text(
                  label,
                  style: Get.textTheme.headlineLarge,
                )),
          ],
        ),
      ),
    ).marginOnly(bottom: 8.0);
  }
}
