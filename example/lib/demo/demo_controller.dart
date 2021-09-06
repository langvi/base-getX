import 'package:base_getx/base_getx.dart';

class DemoController extends BaseGetX{
  var count = 1.obs;
   void increament()async{
     setLoading(true);
     await Future.delayed(Duration(seconds: 2));
     count++;
     setLoading(false);
   }
}