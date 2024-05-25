import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherforecast/models/weather_model.dart';
import 'package:weatherforecast/repositories/waether_repo.dart';
import 'package:weatherforecast/services/location_service.dart';

class WheatherController with ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;
  Placemark? _placemark;

  Placemark get placemark => _placemark!;

  WeatherModel? _weatherModel = null;
  WeatherModel? get weatherModel => _weatherModel;
  LocationService locationService = LocationService();

  void initAppFunctions() {
    getCurrentLocation();
    notifyListeners();
  }

  void getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      } else {
        Position currentPostion = await locationService.getCurrnetLocation();
        getWeather('', isPostion: true, postion: currentPostion);
      }
    } else {
      Position currentPostion = await locationService.getCurrnetLocation();
      getWeather('', isPostion: true, postion: currentPostion);
    }

    notifyListeners();
  }

  void getCountry(currentPostion) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      currentPostion.latitude,
      currentPostion.longitude,
    );
    _placemark = placemarks[0];
    notifyListeners();
  }

  Future<Location> changeLocation(text) async {
    Location location = await locationService.getLocationFromText(text);
    var latitude = location.latitude.toString();
    var longitude = location.longitude.toString();

    List<Placemark> placemarks = await placemarkFromCoordinates(
      location.latitude,
      location.longitude,
    );
    _placemark = placemarks[0];

    notifyListeners();
    return location;
  }

  getWeather(address, {isPostion = false, postion}) async {
    try {
      _loading = true;
      notifyListeners();

      var location;
      getCountry(postion);
      if (isPostion == false) {
        location = await changeLocation(address);
        if (location != null)
          _weatherModel = await WeatherRepo()
              .getWeather(location.latitude, location.longitude);
      } else {
        _weatherModel =
            await WeatherRepo().getWeather(postion.latitude, postion.longitude);
      }
      _loading = false;

      notifyListeners();
      return true;
    } catch (e) {
      _loading = false;

      notifyListeners();
      // const snackBar = SnackBar(
      //   content: Text('Yay! A SnackBar!'),
      // );
      return false;
      // ScaffoldMessenger.of(_).showSnackBar(snackBar);
    }

    _loading = false;
    notifyListeners();
  }
}
