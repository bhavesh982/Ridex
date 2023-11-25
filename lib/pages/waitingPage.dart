import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:login/commons/common_methods.dart';
import 'package:login/pages/currentPlanetPage.dart';
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
  showWarning() {
    showDialog(context: context, builder: (c)=>AlertDialog(
      backgroundColor: mainTheme,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      title:const Text("Warning :"),
      content:const Text("You really want to cancel the ride"),
      actions: [
        TextButton(
            onPressed: () async {
                cancelRide();
                Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=> const CurrentPlanet()));
            }, child: const Text("Yes")),
        TextButton(
            onPressed: () async {
              Navigator.pop(context);
            }, child: const Text("No")),
      ],
    ));
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
  Future<bool> _onBackPressed() async {
    Navigator.push(context, MaterialPageRoute(builder: (c)=> const CurrentPlanet()));
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: mainTheme,
        appBar: AppBar(
          backgroundColor: mainTheme,
        ),
        body: SingleChildScrollView(
          child: Center(
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
                    const SizedBox(height: 150,),
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text("Your request is Accepted !",style: TextStyle(
                        fontSize: 20
                      ),),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text("Wohoo ...",style: TextStyle(
                          fontSize: 16
                      )),
                    ),
                    const SizedBox(height: 150,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonTheme
                            ),
                            onPressed: (){
                          setState(() {
                            if(generatedOtp==0){
                              final otp=rand.nextInt(9999);
                              generatedOtp=otp;
                            }
                            otpGenerated();
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (c)=> const RideConfirmOTP()));
                        }, child: const Text("continue")),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red
                            ),
                            onPressed: (){
                            showWarning();
                        }, child: const Text("Cancel")),
                      ),
                    )
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
        ),
      ),
    );
  }




}
