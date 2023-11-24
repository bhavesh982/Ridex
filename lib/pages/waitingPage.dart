import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../global/global_var.dart';
class WaitingPage extends StatefulWidget {
  const WaitingPage({super.key});

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 300,),
            Text("Please wait"),
            Text("waiting for Spaceline to accept your request"),
            SizedBox(height: 5,),
            LinearProgressIndicator(),
            SizedBox(height: 100,),
            ElevatedButton(
                onPressed: (){}, child: Text("Press")),
          ],
        ),
      ),
    );
  }
}
