import 'package:base_getx/base_getx.dart';
import 'package:example/base/const/const.dart';
import 'package:example/main.dart';

class AppController extends BaseGetXController {
  @override
  void onInit() {
    print("Init app ...");
    initApp();
    super.onInit();
  }
  void initApp() {
    baseRequest = BaseRequestImpl(baseUrl: AppConst.baseUrl);
  }
}
