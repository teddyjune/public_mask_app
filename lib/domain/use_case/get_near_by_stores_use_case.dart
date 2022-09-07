import 'package:geolocator/geolocator.dart';
import 'package:public_mask_app/domain/model/permission.dart';
import 'package:public_mask_app/domain/model/store.dart';
import 'package:public_mask_app/domain/repository/location_permission_repository.dart';
import 'package:public_mask_app/domain/repository/location_repository.dart';
import 'package:public_mask_app/domain/repository/store_repository.dart';
import 'package:public_mask_app/presentation/main_state.dart';

class GetNearByStoresUseCase {
  final StoreRepository _storeRepository;
  final LocationRepository _locationRepository;
  final LocationPermissionRepository _locationPermissionRepository;

  GetNearByStoresUseCase(this._storeRepository, this._locationRepository,
      this._locationPermissionRepository);

  Future<List<Store>> call() async {
    final stores = await _storeRepository.getStores();
    // 기기의 위치 서비스 확인
    final serviceEnabled =
    await _locationPermissionRepository.isLocationServiceEnabled();
    // 권한 체크
    if (serviceEnabled) {
      Permission permission =
      await _locationPermissionRepository.checkPermission();

      if (permission == LocationPermission.denied) {
        //요청
        permission = await _locationPermissionRepository.requestPermission();
        if (permission == Permission.denied) {
          //거부
          return stores;
        }
      }

      if (permission == Permission.deniedForever) {
        //2번 거부
        print('2번 거부');
        return stores;
      }

      final location = await _locationRepository.getLocation();

      return stores.map((store) {
        return MainState.stores
        .copyWith(
        distance: _locationRepository.distanceBetween(
        store.lat.toDouble(),
        store.lng.toDouble(),
        location.latitude,
        location.longitude,
        )
        ,
        );
      }).toList()
        ..sort((a, b) => a.distance!.compareTo(b.distance!));
    }
  }
}
