import 'package:base_getx/base_getx.dart';
import 'package:flutter/material.dart';

void navToScreen({required Widget toPage, void Function()? callBack}) async {
  await Get.to(toPage, transition: Transition.leftToRight);
  if (callBack != null) {
    callBack();
  }
}
