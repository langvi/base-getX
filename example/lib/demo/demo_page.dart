import 'package:base_getx/base_getx.dart';
import 'package:example/base/base_getview/base_getview.dart';
import 'package:example/demo/demo_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class Demo1 extends BaseGetViewApp<DemoController> {
  @override
  Widget builder(BuildContext context) {
    return buildLoading(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Page Demo'),
      ),
    ));
  }

  @override
  void initDependencies() {
    Get.lazyPut(() => DemoController());
    controller.demo();
  }
}
