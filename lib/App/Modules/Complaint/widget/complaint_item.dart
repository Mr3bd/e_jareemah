import 'package:e_jareemah/App/Utilities/Constants/AppStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../Utilities/Constants/AppColors.dart';

class ComplaintItem extends StatelessWidget {
  final String date;
  final int number, status;
  final Function()? onTap;
  const ComplaintItem(
      {super.key,
      required this.date,
      required this.number,
      this.onTap,
      required this.status});

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
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset('assets/icons/single_complaint.png'),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Column(
                    children: [
                      Text(
                        'رقم الشكوى: $number',
                        style: Get.textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'تاريخ الشكوى: ${DateFormat.yMd().format(DateTime.parse(date))}',
                        style: Get.textTheme.titleMedium,
                      ),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    status == 1 ? 'قيد التحري' : 'مغلقة',
                    style: Get.textTheme.titleMedium,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ).marginOnly(bottom: 24.0);
  }
}
