import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:public_mask_app/data/repository/location_permission_repository_impl.dart';
import 'package:public_mask_app/data/repository/location_repository_impl.dart';
import 'package:public_mask_app/data/repository/store_repository_impl.dart';
import 'package:public_mask_app/domain/use_case/get_near_by_stores_use_case.dart';
import 'package:public_mask_app/presentation/main_screen.dart';

import 'presentation/main_view_model.dart';

void main() {
  final useCase = GetNearByStoresUseCase(
    StoreRepositoryImpl(),
    LocationRepositoryImpl(),
    LocationPermissionRepositoryImpl(),
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => MainViewModel(useCase),
    )
  ], child: const MyApp()));
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
      home: const MainScreen(),
    );
  }
}
