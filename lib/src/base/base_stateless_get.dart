import 'dart:io';

import 'package:base_getx/base_getx.dart';
import 'package:base_getx/src/base/base_get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class BaseStatelessGet<C extends BaseGetXController> extends StatelessWidget {
  late final C controller;

  void initController();

  Widget builder(BuildContext context);

  @override
  Widget build(BuildContext context) {
    initController();
    return GetBuilder<C>(
      builder: (controller) {
        return builder(context);
      },
    );
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
}



