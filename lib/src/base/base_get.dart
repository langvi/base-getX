import 'package:base_getx/base_getx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

abstract class BaseGetXOldController extends GetxController {
  RxBool isShowLoading = false.obs;
  @override
  void onInit() {
    print('init $this');
    super.onInit();
  }
  void setLoading(bool isShow) {
    isShowLoading.value = isShow;
  }
}
