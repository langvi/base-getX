import 'package:base_getx/base_getx.dart';
import 'package:example/base/base_getview/base_getnew.dart';
import 'package:example/base/base_getview/base_getview.dart';
import 'package:example/demo/demo_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class Demo1 extends BaseGetWidget<DemoController1> {

  @override
  DemoController1 get controller => Get.put(DemoController1());
  @override
  Widget build(BuildContext context) {
    return buildLoading(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Page Demo'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            // navToScreen(toPage: Demo2());
            Get.to(() => Demo2());
          },
          child: Text('Nav to demo 2'),
        ),
      ),
    ));
  }
}

class Demo2 extends BaseGetWidget<DemoController2> {
  // @override
  // void initDependencies() {
  //   Get.lazyPut(() => DemoController2());
  //   Get.lazyPut(() => DemoController3());
  // }
  @override
  DemoController2 get controller => Get.put(DemoController2());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo 2'),
      ),
      // body: Demo3(),
    );
  }
}

class Demo3 extends BaseGetViewApp2<DemoController3> {
  @override
  Widget builder(BuildContext context) {
    return Text('Hello ${controller.value}');
  }
}
