import 'dart:async';

import 'package:base_getx/base_getx.dart';
import 'package:example/base/const/const.dart';
import 'package:example/weather/weather_page.dart';
import 'package:flutter/material.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(MyApp());
  }, (error, stackTrace) {
    print(error);
    // HandleException.instance.handleExceptionAsync(error, stackTrace);
  });
}

/// hàm này được gọi bên trong hàm  handleExceptionAsync, thường dùng để show thông báo lỗi cho người dùng
late void Function(String errorMessage, int statusCode) onErrorCallBackApp;

/// hàm này được gọi trong basegetxController để gán giá trị cho hàm onErrorCallBackApp
void setCallBackError(Function(String errorMessage, int statusCode) callBack) {
  onErrorCallBackApp = callBack;
}

BaseRequestImpl baseRequest = BaseRequestImpl(baseUrl: AppConst.baseUrl);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Weather Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      home: WeatherPage(),
      // initialBinding: WeatherPage(),
      // getPages: [
      //   GetPage(name: "/", page: () => DemoPage(), binding: DemoBinding())
      // ],
    );
  }
}
