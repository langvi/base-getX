import 'package:base_getx/base_getx.dart';

class DemoController1 extends BaseGetXController {
  void demo() async {
    setLoading(true);
    await Future.delayed(Duration(seconds: 1));
    setLoading(false);
  }
}

class DemoController2 extends BaseGetXController {}

class DemoController3 extends BaseGetXController {
  int value = 2;
}
