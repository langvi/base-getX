import 'package:example/base/const/const.dart';
import 'package:example/main.dart';
import 'package:example/weather/models/weather.dart';

class WeatherRepository {
  Future<Weather> getInfoWeatherByLocation(String location) async {
    var res = await baseRequest.sendGetRequest(AppConst.getWeatherByLocationUrl,
        queryParams: {'query': location}, sendHeader: false);
    List<Map<String, dynamic>> data = [];
    if (res is List) {
      data.add(res.first);
    }
    if (data.isEmpty) {
      return Weather.init();
    }
    return Weather.fromJson(data.first);
  }

  Future<DetailWeather>? getDetailWeatherByLocation(int woeId) async {
    var res = await baseRequest.sendGetRequest(
        'https://www.metaweather.com/api/location' + '/$woeId',
        sendHeader: false);
    List<Map<String, dynamic>> data = [];
    if (res['consolidated_weather'] is List) {
      data.add(res['consolidated_weather'].first);
    }
    if (data.isEmpty) {
      return Future.value(null);
    }
    return DetailWeather.fromJson(data.first);
  }
}
