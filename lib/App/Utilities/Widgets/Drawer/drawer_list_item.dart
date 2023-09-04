import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants/AppColors.dart';

class DrawerListItem extends StatelessWidget {
  final String label;
  final Function()? onTap;

  const DrawerListItem({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(color: AppColors.darkBlue, width: 0.8))),
        child: Text(
          label,
          style: Get.textTheme.titleMedium!.copyWith(color: AppColors.darkBlue),
        ),
      ),
    );
  }
}
