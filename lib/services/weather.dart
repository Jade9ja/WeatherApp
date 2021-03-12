import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
const apiKey = 'dc06a0390f2f1f1f20fe563e173aea59';

class WeatherModel {
  Future getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        Uri.parse('$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric'));
    print(
        Uri.parse('$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric'));
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future getLocationData() async {
    Locator location = Locator();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);
    Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    print(url);
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
