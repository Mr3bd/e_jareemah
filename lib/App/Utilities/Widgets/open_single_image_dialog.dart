import 'dart:io';
import 'package:e_jareemah/App/Utilities/Widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OpenSingleImageDialog extends StatelessWidget {
  final String path;

  const OpenSingleImageDialog({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Dismissible(
            key: const Key('key'),
            onDismissed: (_) => Get.back(),
            direction: DismissDirection.vertical,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: path.contains('http')
                      ? NetworkImage(path)
                      : FileImage(File(path)) as ImageProvider,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: CustomButton(
            onTap: () => Get.back(),
            text: 'رجوع',
          ).marginOnly(bottom: 32.0),
        )
      ],
    );
  }
}
