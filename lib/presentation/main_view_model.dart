import 'package:flutter/foundation.dart';
import 'package:public_mask_app/domain/use_case/get_near_by_stores_use_case.dart';

import 'main_state.dart';

class MainViewModel extends ChangeNotifier {
  final GetNearByStoresUseCase _getNearByStoresUseCase;

  MainState _state = const MainState();

  MainState get state => _state;

  MainViewModel(this._getNearByStoresUseCase) {
    getStores();
  }

  Future getStores() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final stores = await _getNearByStoresUseCase();
    _state = state.copyWith(
      stores: stores,
      isLoading: false,
    );
    notifyListeners();
  }
}
