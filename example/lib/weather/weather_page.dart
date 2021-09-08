import 'package:base_getx/base_getx.dart';
import 'package:example/base/base_getview/base_getview.dart';
import 'package:example/weather/controller/weather_controller.dart';
import 'package:example/weather/views/body_weather.dart';
import 'package:example/demo/demo_page.dart';
import 'package:example/weather/views/error_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class WeatherPage extends BaseGetViewApp<WeatherController> {
  @override
  void initDependencies() {
    Get.lazyPut(() => WeatherController());
    controller.getWeather('London');
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardVisibilityController.onChange.listen((bool visible) {
      print('Keyboard visibility update. Is visible: ${visible}');
    });
  }

  @override
  Widget builder(BuildContext context) {
    return buildLoading(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Demo weather using GetX"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BodyWeather(),
                SizedBox(height: 20,),
                TextButton(onPressed: (){
                  navToScreen(toPage: Demo1());
                }, child: Text('Navigation to Page Demo'))
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // controller.getWeather('London');
            controller.testException();
          },
        ),
      ),
    );
  }
}
