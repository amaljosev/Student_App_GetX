import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:studentgetx/models/student_model.dart';
import 'package:studentgetx/screens/home_screen.dart';

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
      initialRoute: '/',
      getPages:[
        GetPage(name: '/', page:()=> const ScreenHome()), 
      ],
      
    );
  }
}
