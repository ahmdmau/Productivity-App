class WeatherModel {
  String weather;
  double average;

  WeatherModel({required this.weather, required this.average});

  factory WeatherModel.fromMap(Map data) {
    return WeatherModel(
      weather: data['weather'],
      average: data['average'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weather'] = this.weather;
    data['average'] = this.average;
    return data;
  }
}
