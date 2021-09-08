import 'package:base_getx/base_getx.dart';
import 'package:example/weather/controller/weather_controller.dart';
import 'package:flutter/material.dart';

class BodyWeather extends StatelessWidget {
  final _weatherController = Get.find<WeatherController>();
  final _textController = TextEditingController();

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
        ElevatedButton(
            onPressed: () {
              _weatherController.getWeather(_textController.text);
            },
            child: Text('Tìm kiếm'))
      ],
    );
  }

  Widget _buildContent() {
    final weather = _weatherController.weather.value;
    if (weather.detailWeather == null) {
      return  Container();
    }
    return Column(
      children: [
        Text(weather.title),
        Text(
            'Nhiệt độ tại ${weather.title} là ${weather.getTemp()} '),
      ],
    );
  }
}
