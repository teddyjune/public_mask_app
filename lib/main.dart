import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:public_mask_app/model/store.dart';

import 'viewmodel/store_model.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => StoreModel(), child: const MyApp()));
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storeModel = context.watch<StoreModel>();
    return Scaffold(
        appBar: AppBar(
          title: Text('마스크 재고 있는 곳: ${storeModel.stores.where((e) {
            return e.remainStat == 'plenty' || e.remainStat == 'some';
          }).length} 곳'),
          actions: [
            IconButton(
                onPressed: () {
                  storeModel.fetch();
                },
                icon: const Icon(Icons.refresh)),
          ],
        ),
        body: storeModel.isLoading == true
            ? loadingWidget()
            : ListView(
                children: storeModel.stores.where((e) {
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
