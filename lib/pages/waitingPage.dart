import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:login/commons/common_methods.dart';
import 'package:login/pages/rideConfirmOtp.dart';

import '../global/global_var.dart';
import '../widgets/loading_dialog.dart';
class WaitingPage extends StatefulWidget {
  const WaitingPage({super.key});

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  String eventSnap="";
  Random rand =Random();
  CommonMethods cmeds=CommonMethods();
  @override
  void initState() {
    DatabaseReference dref=FirebaseDatabase.instance.ref().child("owners").child(ownerUID).child("riderequest").child(spaceShipName).child(useruid);
    dref.onValue.listen((event) {
       setState(() {
         eventSnap=(event.snapshot.value as Map)["status"];
       });
    });
    super.initState();
  }
  cancelRide() async{
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context)=>LoadingDialog
          (messageText: "Cancelling"));
    Map<String,Object>value={
      "status":"rejected"
    };
    DatabaseReference dref=FirebaseDatabase.instance.ref().child("owners").child(ownerUID).child("riderequest").child(spaceShipName).child(useruid);
    await dref.update(value).whenComplete(() => Navigator.pop(context));
  }
  otpGenerated() async{
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context)=>LoadingDialog
          (messageText: "Generating Otp"));
    Map<String,Object>value={
      "otp":generatedOtp
    };
    DatabaseReference dref=FirebaseDatabase.instance.ref().child("owners").child(ownerUID).child("riderequest").child(spaceShipName).child(useruid);
    await dref.update(value).whenComplete(() {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (c)=> const RideConfirmOTP()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: eventSnap=="pending"?Container(
          child: const Center(
            child: Column(
              children: [
                SizedBox(height: 300,),
                Text("Your request is pending"),
                Text("please wait ..."),
                LinearProgressIndicator()
              ],
            ),
          ),
        ):eventSnap=="accepted"?Container(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 300,),
                const Text("Your request is Accepted"),
                const Text("wohoo ..."),
                const SizedBox(height: 50,),
                ElevatedButton(onPressed: (){
                  setState(() {
                    if(generatedOtp==0){
                      final otp=rand.nextInt(9999);
                      generatedOtp=otp;
                    }
                    otpGenerated();
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> const RideConfirmOTP()));
                }, child: const Text("continue")),
                ElevatedButton(onPressed: (){
                    cancelRide();
                }, child: const Text("Cancel"))
              ],
            ),
          ),
        ):Container(
          child: const Center(
            child: Column(
              children: [
                SizedBox(height: 300,),
                Text("Please Try Again Later"),
                Text("sorry"),
              ],
            ),
          ),
        )
      ),
    );
  }


}
