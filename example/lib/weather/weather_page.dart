import 'package:base_getx/base_getx.dart';
import 'package:example/weather/controller/weather_controller.dart';
import 'package:example/weather/views/body_weather.dart';
import 'package:example/weather/views/error_view.dart';
import 'package:flutter/material.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState
    extends BaseStatefulGet<WeatherPage, WeatherController> {
  @override
  void initController() {
    controller = Get.put(WeatherController());
  }

  @override
  Widget builder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo weather using GetX"),
      ),
      body: BodyWeather(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.getWeather('London');
        },
      ),
    );
  }
}
