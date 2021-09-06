// import 'package:base_getx/base_getx.dart';
// import 'package:example/demo/demo_controller.dart';
// import 'package:flutter/material.dart';
//
// class DemoPage extends BaseStatelessGet<DemoController> {
//   @override
//   void initController() {
//     controller = Get.put(DemoController());
//   }
//   @override
//   Widget builder(BuildContext context) {
//     return buildLoading(
//       child: Scaffold(
//         appBar: AppBar(title: Text('Demo'),),
//         body: Center(
//           child: Obx((){
//             return Text(controller.count.toString());
//           }),
//         ),
//         floatingActionButton: FloatingActionButton(onPressed: (){
//           controller.increament();
//         },),
//       ),
//     );
//   }
// }
import 'package:base_getx/base_getx.dart';
import 'package:example/demo/demo_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class DemoPage extends BaseViewGet<DemoController> {
  @override
  Widget builder(BuildContext context) {
    return buildLoading(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Demo'),
        ),
        body: Center(
          child: Obx(() {
            return Text(controller.count.toString());
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.increament();
          },
        ),
      ),
    );
  }
}
