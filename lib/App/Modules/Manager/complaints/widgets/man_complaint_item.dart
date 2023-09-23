import 'package:e_jareemah/App/Utilities/Constants/AppStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Utilities/Constants/AppColors.dart';
import 'package:intl/intl.dart';

class ManComplaintItem extends StatelessWidget {
  final String date;
  final int number, status, source;
  final String nId;
  final Function()? onTap;
  const ManComplaintItem(
      {super.key,
      required this.date,
      required this.number,
      required this.source,
      this.onTap,
      required this.status,
      required this.nId});

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الرقم الوطني: $nId',
                        style: Get.textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'رقم ${source == 1 ? 'الشكوى' : 'الإبلاغ'}: $number',
                        style: Get.textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'بتاريخ: ${DateFormat.yMd().format(DateTime.parse(date))}',
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
