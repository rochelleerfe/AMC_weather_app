import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/weather.dart';


class WeatherService {
  static const String apiKey = "fb6c0c52edb978f96f09ead7213447c7";
  static const String apiUrl = "https://api.openweathermap.org/data/2.5/weather";

static Future<Weather> getWeather(String cityName) async {
  try {
    final String url = '$apiUrl?q=$cityName&appid=$apiKey&units=metrics';
    final http.Response response = await http.get(Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Weather.fromJson(data);

    }
    else if (response.statusCode == 404) {
      throw Exception('City not found');
    }
    else{
      throw Exception('Failed tp load weather data. Status ${response.statusCode}');
    }

  }
  catch(e) {
    throw Exception('Erroe fetching weather data: $e');
  }

}

}