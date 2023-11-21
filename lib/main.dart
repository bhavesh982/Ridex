import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login/firebase_options.dart';
import 'package:login/pages/destinationPage.dart';

Future<void> main() async{
 WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ridex',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: const DestinationPage(),
    );
  }
}
