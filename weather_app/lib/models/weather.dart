// lib/models/weather.dart

class Weather {
  final String city;
  final double temperature;
  final int humidity;
  final double windSpeed;

  Weather({
    required this.city,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
  });

  // THE FIX IS IN THIS FACTORY CONSTRUCTOR
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['name'],
      temperature: (json['main']['temp'] as num).toDouble(),
      humidity: json['main']['humidity'],

      // **THIS IS THE CRITICAL FIX:**
      // 1. Safely access the 'wind' map using the null-aware operator `?`.
      // 2. Safely access the 'speed' value from the 'wind' map.
      // 3. Use the null-coalescing operator `??` to provide a default value of `0.0`.
      // 4. Cast the final result to a double.
      windSpeed: (json['wind']?['speed'] as num? ?? 0.0).toDouble(),
    );
  }
}
