class Weather {
  Weather({
    required this.title,
    required this.locationType,
    required this.woeid,
    required this.lattLong,
  });

  String title;
  String locationType;
  int woeid;
  String lattLong;
  DetailWeather? detailWeather;
  String getTemp(){
    if(detailWeather!=null){
      return '${detailWeather!.minTemp}°C - ${detailWeather!.maxTemp}°C';
    }
    return '';
  }
  factory Weather.init() {
    return Weather(title: '', locationType: '', woeid: 0, lattLong: '');
  }
  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        title: json["title"],
        locationType: json["location_type"],
        woeid: json["woeid"],
        lattLong: json["latt_long"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "location_type": locationType,
        "woeid": woeid,
        "latt_long": lattLong,
      };
}

class DetailWeather {
  DetailWeather({
    required this.id,
    required this.weatherStateName,
    required this.created,
    required this.applicableDate,
    this.minTemp = 0,
    this.maxTemp = 0,
    this.theTemp = 0,
    this.windSpeed = 0,
    this.windDirection = 0,
    this.airPressure = 0,
    this.humidity = 0,
    this.visibility = 0,
    this.predictability = 0,
  });

  int id;
  String weatherStateName;

  DateTime created;
  DateTime applicableDate;
  double minTemp;
  double maxTemp;
  double theTemp;
  double windSpeed;
  double windDirection;
  double airPressure;
  int humidity;
  double visibility;
  int predictability;

  factory DetailWeather.fromJson(Map<String, dynamic> json) => DetailWeather(
        id: json["id"],
        weatherStateName: json["weather_state_name"],
        created: DateTime.parse(json["created"]),
        applicableDate: DateTime.parse(json["applicable_date"]),
        minTemp: json["min_temp"].toDouble(),
        maxTemp: json["max_temp"].toDouble(),
        theTemp: json["the_temp"].toDouble(),
        windSpeed: json["wind_speed"].toDouble(),
        windDirection: json["wind_direction"].toDouble(),
        airPressure: json["air_pressure"].toDouble(),
        humidity: json["humidity"],
        visibility: json["visibility"].toDouble(),
        predictability: json["predictability"],
      );
}
