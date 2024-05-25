import 'package:weatherforecast/models/weather_model.dart';
import 'package:weatherforecast/providers/base_api_provider.dart';

class WeatherRepo {
  getWeather(lat, long) async {
    String api_key = '4663b947a82e3252891d08fad8c6a12f';
    var response = await ApiProvider.getRequest(
        path:
            'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$api_key&units=metric',
        displayLog: false);
    WeatherModel? weatherModel;
    if (response == null) {
      return null;
    }
    if (response.statusCode == 200) {
      weatherModel = WeatherModel.fromJson(response.data);
      return weatherModel;
    } else {
      return weatherModel;
    }
  }
}
