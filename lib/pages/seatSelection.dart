import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:login/commons/common_methods.dart';

import '../global/global_var.dart';
import '../painter/CurvePainter.dart';
import '../widgets/loading_dialog.dart';

class SeatSelection extends StatefulWidget {
  const SeatSelection({super.key});

  @override
  State<SeatSelection> createState() => _SeatSelectionState();
}

class _SeatSelectionState extends State<SeatSelection> {
  CommonMethods commonMethods=CommonMethods();
  double distance=0;
  double price=0;
  calculationsFare(){
    distance=sqrt(pow((currentPlanetx-destinationPlanetx).abs(), 2)+pow((currentPlanety-destinationPlanety).abs(), 2));
    price=(spaceShipBase*1000)+(spaceShipRate*(distance-1000));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calculationsFare();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
            findOwnerUID();
            sendBookingRequest();
        },
        child: const Icon(Icons.arrow_forward_ios_sharp),
      ),
        appBar: AppBar(
          backgroundColor: const Color(0xff103232),
        ),
        backgroundColor: const Color(0xff103232),
        body: SingleChildScrollView(
          child: Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 1.50,
                color: Colors.grey,
                child: Flexible(
                    child: CustomPaint(
                  painter: CurvePainter(),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 200),
                    child: Row(
                      children: [
                        Flexible(child: firebaseAnimatedList()),
                        Flexible(child: firebaseAnimatedList2()),
                      ],
                    ),
                  ),
                )),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(currentPlanetName.toUpperCase(),style: const TextStyle(
                          fontSize: 18
                        ),),
                        Container(
                          height: 100,
                          width: 100,
                          child: Center(
                            child: Flexible(
                              child: FirebaseAnimatedList(
                                query: FirebaseDatabase.instance
                                        .ref()
                                        .child("spaceships")
                                        .child("company")
                                        .child(spaceLineName)
                                        .child(spaceShipName)
                                        .child("mul"),
                                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                                  return Center(child: Padding(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Text((int.parse(snapshot.value.toString())/10*price).toStringAsFixed(2)),
                                  ));
                              },
                              )
                            ),
                          ),
                        ),
                        Text(destinationPlanetName.toUpperCase(),style: const TextStyle(
                            fontSize: 18))
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }

  FirebaseAnimatedList firebaseAnimatedList2() {
    return FirebaseAnimatedList(
                          shrinkWrap: true,
                          defaultChild: const CircularProgressIndicator(),
                          query: FirebaseDatabase.instance
                              .ref()
                              .child("spaceships")
                              .child("company")
                              .child(spaceLineName)
                              .child(spaceShipName)
                              .child("seats")
                              .child("E1"),
                          itemBuilder: (BuildContext context,
                              DataSnapshot snapshot,
                              Animation<double> animation,
                              int index) {
                            return GestureDetector(
                              onTap: () async {
                                if(snapshot.value.toString()=="E") {
                                  setState(() {
                                    indexOfSeatSelected = index + 11;
                                  });
                                }
                              },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: snapshot.value.toString()=="E"?indexOfSeatSelected==index+11?Colors.blue:Colors.green:Colors.black12,
                                    ),
                                    child: const Icon(Icons.event_seat),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
  }

  FirebaseAnimatedList firebaseAnimatedList() {
    return FirebaseAnimatedList(
      shrinkWrap: true,
      defaultChild: const CircularProgressIndicator(),
      query: FirebaseDatabase.instance
          .ref()
          .child("spaceships")
          .child("company")
          .child(spaceLineName)
          .child(spaceShipName)
          .child("seats")
          .child("E2"),
      itemBuilder: (BuildContext context,
          DataSnapshot snapshot,
          Animation<double> animation,
          int index) {
        return GestureDetector(
          onTap: (){
              if(snapshot.value.toString()=="E") {
            setState(() {
                indexOfSeatSelected = index + 1;
            });}
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: snapshot.value.toString()=="E"?indexOfSeatSelected==index+1?Colors.blue:Colors.green:Colors.black12,
                ),
                child: const Icon(Icons.event_seat),
              ),
            ),
          ),
        );
      },
    );
  }

findOwnerUID() {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context)=>LoadingDialog
        (messageText: "Uploading"));
  DatabaseReference databaseReference=FirebaseDatabase.instance.ref().child("spaceships").child("company").child(spaceLineName).child(spaceShipName);
  databaseReference.once().then((snap){
        userName=snap.snapshot.value.toString();
  }).whenComplete(() => Navigator.pop(context));
}
}
