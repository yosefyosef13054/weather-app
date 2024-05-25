import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
// From a query
  Future<Location> getLocationFromText(query) async {
    // query = "1600 Amphiteatre Parkway, Mountain View";
    print(query);
    var addresses =
        await GeocodingPlatform.instance!.locationFromAddress(query);
    var location = addresses.first;
    print("${location.longitude} : ${location.latitude}");

    return location;
  }

  Future<Position> getCurrnetLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    return position;
  }

  getCountry() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    return position;
  }
}
