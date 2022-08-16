import 'package:geolocator/geolocator.dart';

class LocationRepository {
  Future<Position> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }
}
