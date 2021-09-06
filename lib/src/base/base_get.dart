import 'package:base_getx/base_getx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

abstract class BaseGetX extends GetxController {
  RxBool isShowLoading = false.obs;
  void setLoading(bool isShow){
    isShowLoading.subject.add(isShow);
    isShowLoading = isShow.obs;
  }
  @override
  void onClose() {
    print('Close $this');
    super.onClose();
  }
}
