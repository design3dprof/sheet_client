import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheet_client/pages/login_page.dart';
import 'package:sheet_client/utils/my_routes.dart';

import 'database/datasource.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dataSource = DataSource();
  await dataSource.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fusion 360 Sheet Client App',
      getPages: MyRoutes.getPages(),
      theme: FlexColorScheme.light(
            background: Colors.blueGrey.shade100,
            textTheme: const TextTheme(
              headline1: TextStyle(fontSize: 57),
              headline2: TextStyle(fontSize: 45),
              headline3: TextStyle(fontSize: 36),),
            colors: FlexColor.schemes[FlexScheme.outerSpace]!.light)
            .toTheme,
      home: LoginPage(),
    );
  }
}


