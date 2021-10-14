import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_clone/screens/city_screen.dart';
import 'package:weather_clone/services/weather.dart';
import 'package:weather_clone/utils/constants.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({
    Key? key,
    required this.locationWeather,
  }) : super(key: key);

  final dynamic locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final WeatherModel _weatherModel = WeatherModel();
  late int temperature;
  late int condition;
  late String city;
  late String icon;
  late String msg;
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        icon = 'Error';
        msg = 'Unable to get weather data';
        city = '';
        return;
      }
      condition = weatherData["weather"][0]["id"];
      double temp = weatherData["main"]["temp"];
      temperature = temp.toInt();
      city = weatherData["name"];
      icon = _weatherModel.getWeatherIcon(condition);
      msg = _weatherModel.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: kTransparent,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: kTransparent,
            leading: IconButton(
              onPressed: () async {
                var weatherData = await _weatherModel.getLocationWeather();
                updateUI(weatherData);
              },
              icon: const Icon(
                Icons.my_location,
                color: kBlack,
                size: kIconSize,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.location_city,
                  color: kBlack,
                  size: kIconSize,
                ),
                onPressed: () async {
                  var locationChanged = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CityScreen(),
                    ),
                  );
                  if (locationChanged != null) {
                    var weatherData = await _weatherModel
                        .getCityLocationWeather(locationChanged);
                    updateUI(weatherData);
                  }
                },
              ),
            ],
          ),
          body: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$temperature',
                          style: kTemperatureStyle,
                        ),
                        Text(
                          icon,
                          style: kIconTemperatureStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                msg,
                                textAlign: TextAlign.center,
                                style: kMsgTemperatureStyle,
                              ),
                              Text(
                                city,
                                style: kCityTemperatureStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
