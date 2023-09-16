import 'package:e_jareemah/App/Utilities/Constants/AppColors.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AppLogo extends StatelessWidget {
  final bool withTitle;
  final bool? manager;
  const AppLogo({super.key, this.withTitle = false, this.manager = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 136,
          height: 136,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/${manager! ? 'manager_logo' : 'logo'}.png',
                  width: 136,
                  height: 136,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/heptagram.png',
                  width: 48,
                  height: 48,
                ),
              )
            ],
          ),
        ),
        withTitle
            ? Column(
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
              )
            : const SizedBox()
      ],
    );
  }
}
