import 'package:base_getx/base_getx.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

abstract class GetViewBindings<C extends BaseGetXController> extends GetView<C>
    implements Bindings {}

abstract class GetViewNoneBindings<C extends BaseGetXController>
    extends GetView<C> {}
