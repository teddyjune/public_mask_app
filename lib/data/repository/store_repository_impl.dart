import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:public_mask_app/domain/model/store.dart';

class StoreRepositoryImpl {
  Future<List<Store>> getStores() async {
    final stores = <Store>[];
    Uri url = Uri.parse(
        'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json');
    http.Response response = await http.get(url);
    final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));
    final jsonStores = jsonResult['stores'];
    // setState(() {

    jsonStores.forEach((e) {
      stores.add(Store.fromJson(e));
    });
    print('fetch 완료');
    return stores.where((e) {
      return e.remainStat == 'plenty' || e.remainStat == 'some';
    }).toList();
  }
}
