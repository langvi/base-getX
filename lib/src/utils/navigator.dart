import 'package:base_getx/base_getx.dart';
import 'package:base_getx/src/base/get_view.dart';
import 'package:flutter/material.dart';

// /// Chuyển đến màn mới có sử dung getview
// void navToScreen(
//     {required Widget toPage,
//     Transition transition = Transition.leftToRight,
//     dynamic data,
//     void Function()? callBack}) async {
//   await Get.to(() => toPage, transition: transition, binding: toPage, preventDuplicates: false, arguments: data);
//   if (callBack != null) {
//     callBack();
//   }
// }
//
// /// Chuyển đến màn mới không sử dụng getview
// void navToScreenAnother({required Widget toPage, void Function()? callBack}) async {
//   await Get.to(() => toPage, transition: Transition.leftToRight);
//   if (callBack != null) {
//     callBack();
//   }
// }
//
// /// Chuyển đến màn mới sử dụng getview và đóng tất cả các màn trước nó
// void navToScreenReplaceAll(
//     {required GetViewBindings toPage,
//     Transition transition = Transition.leftToRight,
//     void Function()? callBack}) async {
//   Get.offAll(() => toPage, transition: transition, binding: toPage);
//   if (callBack != null) {
//     callBack();
//   }
// }
//
// /// Chuyển đến màn mới không sử dụng getview và đóng tất cả các màn trước nó
// void navToScreenAnotherReplaceAll({required Widget toPage, void Function()? callBack}) async {
//   await Get.offAll(() => toPage, transition: Transition.leftToRight);
//   if (callBack != null) {
//     callBack();
//   }
// }
