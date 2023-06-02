import 'package:flutter/material.dart';
import 'package:weatherapp/model/weather_data_current.dart';
import 'package:weatherapp/utils/custom_colors.dart';

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
        ),
        Container(
          height: 50,
          width: 1,
          color: CustomColors.dividerline,
        ),
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "${weatherDataCurrent.current.temp!.toInt()}°",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 68,
                color: CustomColors.textColorBlack,
              )),
          TextSpan(
              text: "${weatherDataCurrent.current.weather![0].description}",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.grey,
              ))
        ]))
      ],
    );
  }
}
