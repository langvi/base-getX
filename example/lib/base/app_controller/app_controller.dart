import 'package:base_getx/base_getx.dart';
import 'package:example/base/const/const.dart';
import 'package:example/main.dart';

class AppController extends BaseGetX {
  void initApp() {
    baseRequest = BaseRequest(baseUrl: AppConst.baseUrl);
  }
}