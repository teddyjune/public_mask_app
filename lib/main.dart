import 'package:flutter/material.dart';
import 'package:public_mask_app/model/store.dart';
import 'package:public_mask_app/repository/store_repository.dart';

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
  bool isLoading = false;
  final stores = <Store>[];
  final storeRepository = StoreRepository();

  @override
  void initState() {
    super.initState();
    storeRepository.fetch().then((stores) {
      setState(() {
        stores = stores;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('마스크 재고 있는 곳: ${stores.where((e) {
            return e.remainStat == 'plenty' || e.remainStat == 'some';
          }).length} 곳'),
          actions: [
            IconButton(
                onPressed: () {
                  storeRepository.fetch().then((stores) {
                    setState(() {
                      stores = stores;
                    });
                  });
                },
                icon: const Icon(Icons.refresh)),
          ],
        ),
        body: isLoading
            ? loadingWidget()
            : ListView(
                children: stores.where((e) {
                  return e.remainStat == 'plenty' || e.remainStat == 'some';
                }).map((e) {
                  return ListTile(
                    title: Text(e.name),
                    subtitle: Text(e.address),
                    trailing: _buildRemainingStatWidget(e),
                  );
                }).toList(),
              ));
  }

  Widget _buildRemainingStatWidget(Store store) {
    String remainStat = '판매중지';
    String description = '판매중지';
    var color = Colors.black;

    switch (store.remainStat) {
      case 'plenty':
        remainStat = '충분';
        description = '100개 이상';
        color = Colors.green;
        break;
      case 'some':
        remainStat = '보통';
        description = '30~100개';
        color = Colors.yellow;
        break;
      case 'few':
        remainStat = '부족';
        description = '2~30개';
        color = Colors.red;
        break;
      case 'empty':
        remainStat = '소진임박';
        description = '1개 이하';
        color = Colors.grey;
        break;
      default:
    }

    return Column(
      children: [
        Text(
          remainStat,
          style:
              const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
        Text(description),
      ],
    );
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
