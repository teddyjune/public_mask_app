import 'package:flutter/foundation.dart';
import 'package:public_mask_app/repository/store_repository.dart';

import '../model/store.dart';

class StoreModel extends ChangeNotifier {
  List<Store> stores = [];
  final _storeRepository = StoreRepository();

  Future fetch() async {
    stores = await _storeRepository.fetch();
    notifyListeners();
  }
}
