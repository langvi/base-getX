import 'package:base_getx/base_getx.dart';
import 'package:example/base/base_getview/base_getnew.dart';
import 'package:example/weather/controller/weather_controller.dart';
import 'package:flutter/material.dart';

class BodyWeather extends BaseGetWidget<WeatherController> {
  // final _weatherController = Get.find<WeatherController>();
  final _textController = TextEditingController();

  @override
  WeatherController get controller => Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() {
          return _buildContent();
        }),
        TextFormField(
          controller: _textController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Không hợp lệ';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'Nhập thành phố...',
          ),
        ),
        Obx(() => Text("${controller.count.value}")),
        ElevatedButton(
            onPressed: () {
              controller.getWeather(_textController.text);
            },
            child: Text('Tìm kiếm'))
      ],
    );
  }

  Widget _buildContent() {
    final weather = controller.weather.value;

    if (weather.detailWeather == null) {
      return Container();
    }
    return Column(
      children: [
        Text(weather.title),
        Text('Nhiệt độ tại ${weather.title} là ${weather.getTemp()} '),
      ],
    );
  }
}
