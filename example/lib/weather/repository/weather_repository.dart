import 'package:example/base/const/const.dart';
import 'package:example/main.dart';
import 'package:example/weather/models/weather.dart';
import 'package:base_getx/src/request/abstract_request.dart';

class WeatherRepository {
  Future<Weather?> getInfoWeatherByLocation(String location) async {
    var res = await baseRequest.sendRequest(
        path: AppConst.getWeatherByLocationUrl,
        requestMethod: RequestMethod.GET,
        param: {'query': location},
        sendHeader: false);
    List<Map<String, dynamic>> data = [];
    if (res is List && res.isNotEmpty) {
      data.add(res.first);
    }
    if (data.isEmpty) {
      return null;
    }
    return Weather.fromJson(data.first);
  }

  Future<DetailWeather>? getDetailWeatherByLocation(int woeId) async {
    var res = await baseRequest.sendRequest(
        path: 'https://www.metaweather.com/api/location' + '/$woeId',
        requestMethod: RequestMethod.GET,
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
