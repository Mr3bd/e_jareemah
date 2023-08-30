import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTools {
 
  void unFocusKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  int createRandom() {
    int randomID;
    Random random = Random();
    int randomFirst = random.nextInt(1000000000) + 1000000;
    int randomSecond = random.nextInt(100000) + randomFirst;
    randomID = randomFirst + randomSecond;
    return randomID;
  }

}
