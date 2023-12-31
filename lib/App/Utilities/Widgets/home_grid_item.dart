import 'package:e_jareemah/App/Utilities/Constants/AppStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Constants/AppColors.dart';

class HomeGridItem extends StatelessWidget {
  final Function()? onTap;
  final String label;
  final String icon;

  const HomeGridItem(
      {super.key, this.onTap, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(AppStyles.borderRadius * 2),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: Get.width * 0.25,
            height: Get.width * 0.2,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppStyles.borderRadius * 2),
                border: Border.all(width: 8.0, color: AppColors.milky)),
            child: Image.asset(
              'assets/icons/$icon.png',
              width: 60,
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Text(
            label,
            style:
                Get.textTheme.titleLarge!.copyWith(color: AppColors.darkBlue),
          )
        ],
      ),
    );
  }
}
