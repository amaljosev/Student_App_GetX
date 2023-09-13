import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:studentgetx/getx/routes.dart';
import 'package:studentgetx/models/student_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StudentModelAdapter());
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme:
          ThemeData(primarySwatch: Colors.yellow, brightness: Brightness.dark),
      initialRoute: RouteClass.getHomeRoute(),
      getPages: RouteClass.routes,
    );
  }
}
