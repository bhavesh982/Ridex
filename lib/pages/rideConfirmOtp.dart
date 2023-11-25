import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:login/commons/common_methods.dart';
import 'package:login/global/global_var.dart';
import 'package:login/pages/currentPlanetPage.dart';

import '../widgets/loading_dialog.dart';
class RideConfirmOTP extends StatefulWidget {
  const RideConfirmOTP({super.key});
  @override
  State<RideConfirmOTP> createState() => _RideConfirmOTPState();
}

class _RideConfirmOTPState extends State<RideConfirmOTP> {
  int ratingDone=0;
 CommonMethods commonMethods=CommonMethods();
 TextEditingController _textController=TextEditingController();
 Random rand=Random();
 String eventSnap="";
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff103232),
      appBar: AppBar(
        backgroundColor: const Color(0xff103232),
      ),
      body: SingleChildScrollView(
        child: eventSnap=="finished"?Container(
          child:Column(
            children: [
              const SizedBox(height: 50,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text("Give Feedback !",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                ),
                const SizedBox(height: 30,),
                const Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text("How was your ride",style: TextStyle(
                      fontSize: 16,

                  ),),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        ratingDone=rating.toInt();
                      });
                    },
                  ),
                ),
                SizedBox(height: 50,),
                const Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text("Comments if any ?"),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14
                      ),
                      controller: _textController,
                    ),
                  ),
                ),
                  const SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: ElevatedButton(onPressed: (){
                      submitFeedback();
                    }, child: const Text("Submit")),
                  ),

              ],
            ),
            ],
          ) ,
        ) :Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50,), const Padding(
                padding: EdgeInsets.only(top: 40,left: 40),
                child: ListTile(
                  title: Text("Secret code!",style: TextStyle(
                      fontSize: 22
                  ),),
                  subtitle: Text("for your journey."),
                ),
              ),
              Container(height: 100,
                width: 100,
                child: Text(generatedOtp.toString(),style: const TextStyle(
                    fontSize: 35
                ),),
              ),
              const SizedBox(height: 150,)
            ],
          ),
        )
      ),
    );
  }

  submitFeedback() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context)=>LoadingDialog
          (messageText: "Loading"));
    Map<String,Object>feeds={
      "rating": ratingDone,
      "comments":_textController.text.trim()
    };
    Map<String,Object>value={
      "feedback": feeds
    };
    DatabaseReference dref=FirebaseDatabase.instance.ref().child("owners").child(ownerUID).child("riderequest").child(spaceShipName).child(useruid);
    await dref.update(value).whenComplete(() {
      _textController.clear();
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (c)=> const CurrentPlanet()));
    });
  }
}
