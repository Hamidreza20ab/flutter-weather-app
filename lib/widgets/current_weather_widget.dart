import 'package:flutter/material.dart';
import 'package:weatherapp/model/weather_data_current.dart';

class CurrentWeatherWidget extends StatelessWidget {
  const CurrentWeatherWidget({super.key, required this.weatherDataCurrent});
  final WeatherDataCurrent weatherDataCurrent;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Temprature area
        tempratureAreaWidget(),
        //more details-windspeed, humadity, clouds
        currentWeatherMoreDetailsWidget(),
      ],
    );
  }

  Widget currentWeatherMoreDetailsWidget() {
    return Container();
  }

  Widget tempratureAreaWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          'assets/weather/${weatherDataCurrent.current.weather![0].icon}.png',
          height: 80,
          width: 80,
        )
      ],
    );
  }
}
