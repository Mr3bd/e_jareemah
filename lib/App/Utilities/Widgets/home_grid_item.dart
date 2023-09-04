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
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: AppColors.milky,
                boxShadow: [AppStyles.primaryShadow],
                borderRadius:
                    BorderRadius.circular(AppStyles.borderRadius * 2)),
            child: Container(
              width: Get.width * 0.2,
              height: Get.width * 0.2,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppStyles.borderRadius * 2),
              ),
              child: Image.asset(
                'assets/icons/$icon.png',
                fit: BoxFit.fitWidth,
              ),
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
