import 'package:dio/dio.dart';
import 'package:weather_app/constants/api_path.dart';
import 'package:weather_app/model/weather_model.dart';

mixin ApiService {
  Future<WeatherModel> getWeatherModel() async {
    final Dio dio = Dio(BaseOptions(
      baseUrl: 'https://api.open-meteo.com',
    ));

    final response = await dio.get(ApiPath.weatherPath, queryParameters: {
      'latitude': 52,
      'longitude': 13.41,
      'daily': [
        'weathercode',
        'temperature_2m_max',
        'temperature_2m_min',
        'sunrise',
        'sunset'
      ],
      'timezone': 'auto',
      'past_days': 3,
    });

    return WeatherModel.fromJson(response.data);
  }
}
