import 'package:e_jareemah/App/Utilities/Constants/AppStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utilities/Constants/AppColors.dart';

class ComplaintDetailItem extends StatelessWidget {
  final String label;
  final String? value;
  final bool? withBack;

  const ComplaintDetailItem(
      {super.key, required this.label, this.value, this.withBack = true});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: Get.textTheme.headlineSmall!.copyWith(
              fontSize: 18.0,
              color: AppColors.darkBlue,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 8.0,
        ),
        value != null
            ? Column(
                children: [
                  Container(
                    width: Get.width * 0.7,
                    padding:
                        withBack == true ? const EdgeInsets.all(8.0) : null,
                    decoration: withBack == true
                        ? BoxDecoration(
                            color: AppColors.milky.withOpacity(0.75),
                            borderRadius:
                                BorderRadius.circular(AppStyles.borderRadius),
                          )
                        : null,
                    child: Text(
                      value!,
                      textAlign: TextAlign.start,
                      style: Get.textTheme.headlineSmall!.copyWith(
                          fontSize: 16.0,
                          color: AppColors.grey.withOpacity(0.7)),
                    ),
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                ],
              )
            : const SizedBox(
                height: 16.0,
              )
      ],
    );
  }
}
