import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:public_mask_app/repository/store_repository.dart';

import '../model/store.dart';
import '../repository/location_repository.dart';

class StoreModel extends ChangeNotifier {
  List<Store> stores = [];
  bool isLoading = false;
  final _storeRepository = StoreRepository();
  final _locationRepository = LocationRepository();

  StoreModel() {
    fetch();
  }

  Future fetch() async {
    isLoading = true;
    notifyListeners();
    Position position = await _locationRepository.getCurrentLocation();
    stores = await _storeRepository.fetch(
      position.latitude,
      position.longitude,
    );
    isLoading = false;
    notifyListeners();
  }
}
