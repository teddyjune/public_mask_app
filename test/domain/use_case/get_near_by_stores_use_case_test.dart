import 'package:flutter_test/flutter_test.dart';
import 'package:public_mask_app/data/mock_data.dart';
import 'package:public_mask_app/domain/use_case/get_near_by_stores_use_case.dart';

void main() {
  final useCase = GetNearByStoresUseCase(
    MockNearbyStoreRepository(),
    MockLocationRepository(),
    MockLocationPermissionRepositoryImpl(),
  );

  test('가까운 순서대로 정렬되어야 한다', () async {
    final stores = await useCase();

    expect(stores[0].name, '안양약국');
    expect(stores[1].name, '수원약국');
    expect(stores[2].name, '평택약국');
  });
}
