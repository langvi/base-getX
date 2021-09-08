import 'package:base_getx/base_getx.dart';

class DemoController extends BaseGetXController {
  void demo() async {
    setLoading(true);
    await Future.delayed(Duration(seconds: 1));
    setLoading(false);
  }
}
