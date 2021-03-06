import 'package:weather_clone/services/location.dart';
import 'package:weather_clone/services/networking.dart';

Location _location = Location();
Networking _networking = Networking();
const key = '38fbbab251f7e6bb7f4994a6f216e3cf';
const host = 'https://api.openweathermap.org/data/2.5/weather?';

class WeatherModel {
  Future<dynamic> getCityLocationWeather(city) async {
    String option = 'q=$city&appid=$key&units=metric';
    var weatherData = await _networking.fetchData(host + option);
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    await _location.getCurrentLocation();
    print(_location.longitude);
    String option =
        'lat=${_location.latitude}&lon=${_location.longitude}&appid=$key&units=metric';
    var weatherData = await _networking.fetchData(host + option);
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
