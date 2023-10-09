// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasfah/loginpage/loginscreen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:wasfah/onboardingscreen/onboardingpage.dart';
import 'package:wasfah/testapp/arrayadd.dart';
import 'package:wasfah/testapp/selectimage.dart';

import 'package:wasfah/view/screen/homepage/homepage.dart';
import 'package:firebase_core/firebase_core.dart';

String? idshared;
bool? repeatshared;
bool? onboarder;
ConnectivityResult? listenconnetivtey;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefget = await SharedPreferences.getInstance();
  idshared = prefget.getString("id");
  repeatshared = prefget.getBool('repeat');
  onboarder = prefget.getBool('onboarder');
  print(onboarder);

  print("===============================================");
  print(repeatshared);
  (Connectivity().onConnectivityChanged.listen((event) {
    print("===============================================");
    listenconnetivtey = event;
    print(listenconnetivtey);
    print("===============================================");
  }));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wasfah',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 241, 241, 241),
        // scaffoldBackgroundColor: const Color(0xffFFF1E8),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),

      // home: const MyHomePageGIF(),
      home: StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
              child: onboarder == true
                  ? repeatshared == true
                      ? MyHomePage(
                          iduser: idshared!,
                        )
                      : const LogInPage()
                  : const OnBoarding());
        },
      ),
    );
  }
}
