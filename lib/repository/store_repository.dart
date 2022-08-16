import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:public_mask_app/model/store.dart';

class StoreRepository {
  Future<List<Store>> fetch() async {
    final stores = <Store>[];
    // setState(() {
    //   isLoading = true;
    // });
    Uri url = Uri.parse(
        'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json');
    http.Response response = await http.get(url);
    final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));
    final jsonStores = jsonResult['stores'];
    // setState(() {

    jsonStores.forEach((e) {
      stores.add(Store.fromJson(e));
    });
    // isLoading = false;
    // });
    print('fetch 완료');
    return stores;
  }
}