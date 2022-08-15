import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:public_mask_app/model/store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final stores = [];
  bool isLoading = true;

  Future fetch() async {
    setState(() {
      isLoading = true;
    });
    Uri url = Uri.parse(
        'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json');
    http.Response response = await http.get(url);
    final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));
    final jsonStores = jsonResult['stores'];
    setState(() {
      stores.clear(); //새로고침에 대응
      jsonStores.forEach((e) {
        stores.add(Store.fromJson(e));
      });
      isLoading = false;
    });
    print('fetch 완료');
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('마스크 재고 있는 곳: ${stores.length} 곳'),
          actions: [
            IconButton(onPressed: fetch, icon: const Icon(Icons.refresh)),
          ],
        ),
        body: isLoading
            ? loadingWidget()
            : ListView(
                children: stores.map((e) {
                  return ListTile(
                    title: Text(e.name),
                    subtitle: Text(e.address),
                    trailing: Text(e.remainStat ?? '매진'),
                  );
                }).toList(),
              ));
  }
}

Widget loadingWidget() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('정보를 가져오는 중'),
        CircularProgressIndicator(),
      ],
    ),
  );
}
