import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:public_mask_app/domain/model/location.dart';
import 'package:public_mask_app/domain/repository/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  @override
  Future<Location> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return Location(position.latitude, position.longitude);
  }

  @override
  double distanceBetween(
      double startLat, double startLng, double endLat, double endLng) {
    return Geolocator.distanceBetween(startLat, startLng, endLat, endLng);
  }
}
