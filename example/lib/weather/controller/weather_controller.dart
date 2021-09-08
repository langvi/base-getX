import 'package:base_getx/base_getx.dart';
import 'package:example/weather/models/weather.dart';
import 'package:example/weather/repository/weather_repository.dart';

class WeatherController extends BaseGetXController {
  Rx<Weather> weather = Weather.init().obs;
  final _repository = WeatherRepository();

  void getWeather(String location) async {
    setLoading(true);
    weather.value = await _repository.getInfoWeatherByLocation(location);
    weather.value.detailWeather =
        await _repository.getDetailWeatherByLocation(weather.value.woeid);
    if (weather.value.detailWeather != null) {
      weather.subject.add(weather.value);
    }
    setLoading(false);
  }

  void testException() async {
    await Future.delayed(Duration(seconds: 1));
    print(int.parse('ss'));
  }
}
mixin DetectKeyBoardShow{

}
