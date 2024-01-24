import 'package:base_getx/base_getx.dart';

class DemoController1 extends BaseGetXOldController {
  void demo() async {
    setLoading(true);
    await Future.delayed(Duration(seconds: 1));
    setLoading(false);
  }
  @override
  void onInit() {
    print("Init....");
    super.onInit();
  }
}

class DemoController2 extends BaseGetXOldController {}

class DemoController3 extends BaseGetXOldController {
  int value = 2;
}
