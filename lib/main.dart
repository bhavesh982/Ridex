import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login/authentication/login_screen.dart';
import 'package:login/firebase_options.dart';
import 'package:login/pages/currentPlanetPage.dart';
import 'package:login/pages/destinationPage.dart';
import 'package:login/pages/seatSelection.dart';
import 'package:login/splashScreen/splashScreen.dart';

Future<void> main() async{
 WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ridex',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: SplashScreen()
      //FirebaseAuth.instance.currentUser?.uid==null?const LoginScreen():const DestinationPage(),
    );
  }
}
