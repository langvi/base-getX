import 'package:base_getx/base_getx.dart';
import 'package:example/base/app_controller/app_controller.dart';
import 'package:example/weather/weather_page.dart';
import 'package:flutter/material.dart';

void main() async {
  runMainApp(myApp: MyApp());
}

late BaseRequest baseRequest;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends BaseStatefulGet<MyApp, AppController> {
  @override
  void initController() {
    controller = Get.put(AppController());
    controller.initApp();
  }

  @override
  Widget builder(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Weather Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherPage(),
    );
  }
}
