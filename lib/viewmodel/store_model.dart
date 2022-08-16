import 'package:flutter/foundation.dart';
import 'package:public_mask_app/repository/store_repository.dart';

import '../model/store.dart';

class StoreModel extends ChangeNotifier {
  List<Store> stores = [];
  bool isLoading = false;

  final _storeRepository = StoreRepository();

  StoreModel() {
    fetch();
  }

  Future fetch() async {
    isLoading = true;
    notifyListeners();

    stores = await _storeRepository.fetch();
    isLoading = false;
    notifyListeners();
  }
}
