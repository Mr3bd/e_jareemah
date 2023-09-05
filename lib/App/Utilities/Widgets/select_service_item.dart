import 'package:e_jareemah/App/Utilities/Constants/AppStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Constants/AppColors.dart';

class SelectServiceItem extends StatelessWidget {
  final String icon, label;
  final Function()? onTap;
  const SelectServiceItem(
      {super.key, required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 16.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: AppColors.milky,
            boxShadow: [AppStyles.primaryShadow],
            borderRadius: BorderRadius.circular(AppStyles.borderRadius * 1.5)),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius:
                  BorderRadius.circular(AppStyles.borderRadius * 1.5)),
          child: Row(
            children: [
              Image.asset('assets/icons/$icon.png'),
              const SizedBox(
                width: 8.0,
              ),
              Text(
                label,
                style: Get.textTheme.titleLarge!
                    .copyWith(color: AppColors.darkBlue),
              )
            ],
          ),
        ),
      ),
    ).marginOnly(bottom: 24.0);
  }
}
