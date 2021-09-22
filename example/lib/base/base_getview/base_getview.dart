import 'dart:io';

import 'package:base_getx/base_getx.dart';
import 'package:example/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

abstract class BaseGetViewApp<C extends BaseGetXController>
    extends GetViewBindings<C> {
  Widget builder(BuildContext context);

  void initDependencies();

  @override
  void dependencies() {
    initDependencies();
    setCallBackError(handleDioError);
  }

  @override
  Widget build(BuildContext context) {
    return builder(context);
  }

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

abstract class BaseGetViewApp2<C extends BaseGetXController>
    extends GetView<C> {
  Widget builder(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return builder(context);
  }

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
