import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:public_mask_app/ui/remain_stat_listtile.dart';
import '../viewmodel/store_model.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storeModel = context.watch<StoreModel>();
    return Scaffold(
        appBar: AppBar(
          title: Text('마스크 재고 있는 곳: ${storeModel.stores.length} 곳'),
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
                children: storeModel.stores.map((e) {
                  return ListTile(
                    title: Text(e.name),
                    subtitle: Text(e.address),
                    trailing: RemainStatListtile(e),
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
