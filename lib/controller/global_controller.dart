import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  //create variable values
  final RxBool _isloading = true.obs;
  final RxDouble _lattitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  //instance for them to be called
  RxBool checkLoading() => _isloading;
  RxDouble checkLatitude() => _lattitude;
  RxDouble checkLonitude() => _longitude;
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
      return Future.error("Location Permission are denied forever");
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
        _isloading.value = false;
      });
    }
  }
}
