import 'package:flutter/material.dart';

import 'AppColors.dart';

class AppStyles {
  static BoxShadow primaryShadow = BoxShadow(
    color: AppColors.black.withOpacity(0.1),
    blurRadius: 5,
    spreadRadius: 0.2,
    offset: const Offset(0, 3),
  );

  static const double borderRadius = 10.0;
}
