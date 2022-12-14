import 'package:public_mask_app/domain/model/permission.dart';

abstract class LocationPermissionRepository {
  Future<bool> isLocationServiceEnabled();

  Future<Permission> checkPermission();

  Future<Permission> requestPermission();
}
