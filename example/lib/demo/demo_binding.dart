import 'package:base_getx/base_getx.dart';
import 'package:example/demo/demo_controller.dart';

class DemoBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DemoController());
  }
}