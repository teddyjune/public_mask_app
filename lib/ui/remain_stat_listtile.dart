import 'package:flutter/material.dart';

import '../model/store.dart';

class RemainStatListtile extends StatelessWidget {
  final Store store;
  const RemainStatListtile(this.store, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildRemainingStatWidget(store);
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
