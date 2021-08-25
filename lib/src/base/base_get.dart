import 'package:dio/dio.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

abstract class BaseGetX extends GetxController {
  bool isShowLoading = false;

  @override
  void onClose() {
    print('Close $this');
    super.onClose();
  }
}
