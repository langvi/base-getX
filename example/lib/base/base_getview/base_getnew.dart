import 'dart:io';

import 'package:base_getx/base_getx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class BaseGetWidget<T extends BaseGetXOldController> extends GetView<T>{
  Widget buildViewLoading() {
    return Container(
      color: Colors.black38,
      child: Center(
        child: Platform.isAndroid
            ? CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          backgroundColor: Colors.black38,
        )
            : CupertinoActivityIndicator(radius: 10, animating: true),
      ),
    );
  }

  Widget buildLoading({required Widget child}) {
    return Stack(
      children: <Widget>[
        child,
        Obx(() {
          return Visibility(
              visible: controller.isShowLoading.value,
              child: buildViewLoading());
        }),
      ],
    );
  }

  void handleDioError(String message, int statusCode) {
    controller.setLoading(false);
    if (statusCode == 401) {
      ShowDialog().showDialogNotification(
          title: 'Thông báo',
          content: message,
          onClick: () {
            // navToScreenReplaceAll(toPage: toPage)
          });
    } else {
      ShowDialog().showDialogNotification(
        title: 'Thông báo',
        content: message,
      );
    }
  }
}