import 'package:public_mask_app/data/data_source/store_api.dart';
import 'package:public_mask_app/domain/model/store.dart';
import 'package:public_mask_app/domain/repository/store_repository.dart';

class StoreRepositoryImpl implements StoreRepository {
  final _api = StoreApi();

  @override
  Future<List<Store>> getStores() async {
    final dto = await _api.getStoresInfo();
    if (dto.stores == null) {
      return [];
    }
    return dto.stores!
        .where((e) => e.name != null)
        .map((e) => Store(
            lat: e.lat! ?? 0.0,
            lng: e.lng! ?? 0.0,
            name: e.name ?? '이름 없음',
            address: e.addr ?? '',
            remainStat: e.remainStat ?? '알 수 없음',
            distance: null))
        .toList();
  }
}
