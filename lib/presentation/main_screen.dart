import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:public_mask_app/presentation/remain_stat_listtile.dart';

import 'main_view_model.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storeModel = context.watch<MainViewModel>();
    final state = storeModel.state;

    return Scaffold(
        appBar: AppBar(
          title: Text('마스크 재고 있는 곳: ${state.stores.length} 곳'),
          actions: [
            IconButton(
                onPressed: () {
                  storeModel.getStores();
                },
                icon: const Icon(Icons.refresh)),
          ],
        ),
        body: state.isLoading == true
            ? loadingWidget()
            : ListView(
                children: state.stores.map((e) {
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
