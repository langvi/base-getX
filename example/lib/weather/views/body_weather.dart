import 'package:base_getx/base_getx.dart';
import 'package:example/weather/controller/weather_controller.dart';
import 'package:flutter/material.dart';

class BodyWeather extends StatelessWidget {
  final _weatherController = Get.find<WeatherController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildContent(),
        TextFormField(
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
        ElevatedButton(onPressed: () {}, child: Text('Tìm kiếm'))
      ],
    );
  }

  Widget _buildContent() {
    if (_weatherController.weather.detailWeather == null) {
      return _weatherController.isShowLoading
          ? Container(width: 40, height: 40, child: CircularProgressIndicator())
          : Container();
    }
    return Column(
      children: [
        Text(_weatherController.weather.title),
        Text(
            'Nhiệt độ tại ${_weatherController.weather.title} là ${_weatherController.weather.getTemp()} '),
      ],
    );
  }
}
