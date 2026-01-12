import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/models/weather.dart';

void main() {
  group('Weather.fromJson', () {
    test('should correctly parse a realistic JSON response from OpenWeatherMap', () {
      // A realistic JSON response for Manila, PH from OpenWeatherMap.
      const String jsonString = '''
      {
        "coord": {"lon": 120.9822, "lat": 14.6042},
        "weather": [{"id": 803, "main": "Clouds", "description": "broken clouds", "icon": "04n"}],
        "base": "stations",
        "main": {"temp": 298.15, "feels_like": 301.15, "temp_min": 297.59, "temp_max": 299.82, "pressure": 1014, "humidity": 78},
        "visibility": 10000,
        "wind": {"speed": 2.06, "deg": 210},
        "clouds": {"all": 75},
        "dt": 1673539200,
        "sys": {"type": 1, "id": 8166, "country": "PH", "sunrise": 1673476254, "sunset": 1673517842},
        "timezone": 28800,
        "id": 1701668,
        "name": "Manila",
        "cod": 200
      }
      ''';

      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      final weather = Weather.fromJson(jsonMap);

      // 3. Assert that the Weather object's properties match the JSON data
      // CORRECTION: Use `weather.cityName` and add `weather.condition`
      expect(weather.city, 'Manila');
      expect(weather.temperature, 298.15);
      expect(weather.humidity, 78);
      expect(weather.windSpeed, 2.06);
    });

    test('should handle different main condition values', () {
      final jsonMap = {
        "name": "Malabon",
        "main": {"temp": 280.32, "humidity": 81},
        "weather": [{"main": "Rain"}],
        "wind": {"speed": 4.1}
      };

      final weather = Weather.fromJson(jsonMap);

      // CORRECTION: Use `weather.cityName` and add `weather.condition`
      expect(weather.city, 'Manila');
      expect(weather.temperature, 280.32);
      expect(weather.humidity, 81);
      expect(weather.windSpeed, 4.1);
    });

    test('should handle missing optional fields gracefully', () {
      // This JSON is missing the 'wind' key.
      final jsonMap = {
        "name": "Test City",
        "main": {"temp": 300.0, "humidity": 50},
        "weather": [{"main": "Clear"}]
      };

      final weather = Weather.fromJson(jsonMap);

      // CORRECTION: Use `weather.cityName` and add `weather.condition`
      expect(weather.city, 'Test City');
      expect(weather.temperature, 300.0);

      expect(weather.humidity, 50);
      // Assert that windSpeed correctly defaults to 0.0 when 'wind' is missing.
      expect(weather.windSpeed, 0.0);
    });
  });
}
