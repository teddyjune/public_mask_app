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
      home: MyHomePage(),
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

  Future fetch() async {
    Uri url = Uri.parse(
        'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json');
    http.Response response = await http.get(url);
    final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));
    final stores = jsonResult['stores'];

    stores.clear(); //새로고침에 대응
    stores.forEach((e) {
      stores.add(Store.fromJson(e));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('마스크 재고 있는 곳: 0 곳'),
        ),
        body: ListView(
          children: stores.map((e) {
            return ListTile(
              title: Text(e.name),
              subtitle: Text(e.addr),
            );
          }).toList(),
        ));
  }
}
