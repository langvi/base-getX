import 'package:base_getx/base_getx.dart';
import 'package:example/weather/models/weather.dart';
import 'package:example/weather/repository/weather_repository.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class WeatherController extends BaseGetXOldController {
  Rx<Weather> weather = Weather.init().obs;
  final _repository = WeatherRepository();
  Rx<int> count = 1.obs;
  final keyboardVisibilityController = KeyboardVisibilityController();

  @override
  void onInit() {

    keyboardVisibilityController.onChange.listen((bool visible) {
      print('Keyboard visibility update. Is visible: $visible');
    });
    super.onInit();
  }

  void getWeather(String location) async {
    setLoading(true);
    var data = await _repository.getInfoWeatherByLocation(location);
    if (data != null) {
      weather.value = data;
      weather.value.detailWeather =
          await _repository.getDetailWeatherByLocation(weather.value.woeid);
      if (weather.value.detailWeather != null) {
        weather.subject.add(weather.value);
      }
    }

    setLoading(false);
  }

  void testException() async {
    await Future.delayed(Duration(seconds: 1));
    print(int.parse('ss'));
  }
}
