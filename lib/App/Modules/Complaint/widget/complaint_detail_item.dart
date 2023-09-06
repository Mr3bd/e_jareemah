import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utilities/Constants/AppColors.dart';

class ComplaintDetailItem extends StatelessWidget {
  final String label, value;

  const ComplaintDetailItem(
      {super.key, required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 32.0,
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: Get.textTheme.headlineSmall!.copyWith(
              fontSize: 18.0,
              color: AppColors.darkBlue,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Text(
          value,
          textAlign: TextAlign.center,
          style: Get.textTheme.headlineSmall!
              .copyWith(fontSize: 16.0, color: AppColors.grey.withOpacity(0.7)),
        ),
      ],
    );
  }
}
