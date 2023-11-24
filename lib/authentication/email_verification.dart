import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/authentication/login_screen.dart';
import 'package:login/commons/common_methods.dart';

import '../widgets/loading_dialog.dart';
class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  CommonMethods commonMethods= CommonMethods();
  Duration myDuration = const Duration(seconds:1);
  bool counterVar=true;
  late Timer _timer;
  int counter=0;
  void Countdown(){
    counter=10;
    _timer=Timer.periodic(myDuration, (timer) {
      if(counter>0){
        setState(() {
          counter--;
        });
      }
        else{
          _timer.cancel();
          setState(() {
            counterVar=true;
          });
      }
    });
  }
  @override
  checkemailVerified()async{
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context)=>LoadingDialog
          (messageText: "Verifying"));
    User? user = FirebaseAuth.instance.currentUser;
    await user?.reload().whenComplete(() => Navigator.pop(context));
    bool check = user!.emailVerified;
    if(check){
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (c)=>const  LoginScreen()));
    }
    else{
      await user.reload().whenComplete(() => Navigator.pop(context));
      commonMethods.displaySnackBar("Verify Email First", context);
    }
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify"),
      ),
      body: Center(
        child: counterVar?ElevatedButton(
          onPressed: ()async{
            setState(() {
              counterVar=false;
            });
            Countdown();

            await checkemailVerified();
          },
          child: const Text("Verify"),
        ):ElevatedButton(
          onPressed: (){
          },
          child: Text("$counter"),
        ),
      ),
    );
  }

}
