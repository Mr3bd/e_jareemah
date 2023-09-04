import 'package:e_jareemah/App/Utilities/Constants/AppColors.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AppLogo extends StatelessWidget {
  final bool withTitle;
  const AppLogo({super.key, this.withTitle = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 144,
          height: 144,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 144,
                  height: 144,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/heptagram.png',
                  width: 56,
                  height: 56,
                ),
              )
            ],
          ),
        ),
       withTitle?  Column(
          children: [
            const SizedBox(
              height: 12.0,
            ),
            Text(
              'جريمة',
              style: Get.textTheme.headlineSmall!
                  .copyWith(color: AppColors.darkBlue),
            ),
          ],
        ) : const SizedBox()
      ],
    );
  }
}
