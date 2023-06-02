import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weatherapp/api/fetch_weather.dart';
import 'package:weatherapp/model/weather_data.dart';

class GlobalController extends GetxController {
  //create variable values
  final RxBool _isloading = true.obs;
  final RxDouble _lattitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  //instance for them to be called
  RxBool checkLoading() => _isloading;
  RxDouble getLatitude() => _lattitude;
  RxDouble getLongitude() => _longitude;
  final weatherData = WeatherData().obs;
  WeatherData getWeatherData() {
    return weatherData.value;
  }

  @override
  void onInit() {
    if (_isloading.isTrue) {
      getLocation();
    }

    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //returns is service is nor enebled
    if (!isServiceEnabled) {
      return Future.error("Location not enebled");
    }
    //status of permission
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location Permissions are denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      //request permission
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location permission is denied");
      }
      //getting the current position
      return await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((value) {
        //update our lattitude and longitude
        _lattitude.value = value.latitude;
        _longitude.value = value.longitude;
        //calling our weather api

        return FetchWeatherApi()
            .processData(value.latitude, value.longitude)
            .then((value) {
          weatherData.value = value;
          _isloading.value = false;
        });
      });
    }
  }
}
