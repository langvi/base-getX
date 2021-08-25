import 'package:base_getx/base_getx.dart';
import 'package:example/weather/models/weather.dart';
import 'package:example/weather/repository/weather_repository.dart';

class WeatherController extends BaseGetX {
  Weather weather = Weather.init();
  final _repository = WeatherRepository();

  void getWeather(String location) async {
    isShowLoading = true;
    update();
    weather = await _repository.getInfoWeatherByLocation(location);
    weather.detailWeather = await _repository.getDetailWeatherByLocation(weather.woeid);
      if (weather.detailWeather != null) {
        isShowLoading = false;
      }
    update();
  }
}
