import 'package:get/get.dart';
import 'package:studentgetx/screens/add/add_screen.dart';
import 'package:studentgetx/screens/home_screen.dart';
import 'package:studentgetx/screens/profile/profile_screen.dart';

class RouteClass {
  static String home='/';
  static String addScreen='/addScreen';
  static String profileScreen='/profile'; 

  static String getHomeRoute()=>home;
  static String getAddScreenRoute()=>addScreen; 
  static String getProfileRoute()=>profileScreen;

  static List <GetPage>routes=[
    GetPage(name: home, page: ()=>const ScreenHome()),
     GetPage(name: addScreen, page: ()=>const ScreenAdd()), 
     GetPage(name: profileScreen, page: () => const ScreenProfile(),),
  ];
}