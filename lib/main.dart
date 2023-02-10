
import 'package:ekart/consts/consts.dart';
import 'package:ekart/consts/strings.dart';
import 'package:ekart/view/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // we are using Getx so we have to change this materialapp into getmaterialapp
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
              //to set app bar icons color
              iconTheme: IconThemeData(
                color: Appcolors.darkFontGrey,
              ),
              backgroundColor: Colors.transparent),
          fontFamily: regular),
      home: SplashScreen(),
    );
  }
}
