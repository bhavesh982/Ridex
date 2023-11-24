import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:login/global/global_var.dart';
import 'package:login/pages/rideConfirmOtp.dart';
import 'package:login/pages/seatSelection.dart';
import 'package:login/pages/spaceShipPage.dart';

import '../commons/common_methods.dart';
import '../widgets/loading_dialog.dart';

class SpaceShipsList extends StatefulWidget {
  const SpaceShipsList({super.key});

  @override
  State<SpaceShipsList> createState() => _SpaceShipsListState();
}

class _SpaceShipsListState extends State<SpaceShipsList> {
  CommonMethods commonMethods = CommonMethods();
  Random random=Random();
  int otp=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            '',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: mainTheme,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Spaceships",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: FirebaseAnimatedList(
                defaultChild: const Center(child: LinearProgressIndicator()),
                query: FirebaseDatabase.instance
                    .ref()
                    .child("spaceships")
                    .child("company")
                    .child(spaceLineName),
                itemBuilder: (context, snapshot, animation, index) {
                  if (snapshot.key.toString() != "logo") {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffe9e9e9),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        height: 200,
                        child: Column(
                          children: [
                            Container(
                                height: 130,
                                width: double.infinity,
                                child: CachedNetworkImage(
                                  imageUrl:
                                  snapshot.child("image").value.toString(),
                                  placeholder: (context, url) =>
                                  const LinearProgressIndicator(),
                                  imageBuilder: (context, imageprovider) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          image: DecorationImage(
                                              image: imageprovider,
                                              fit: BoxFit.fill)),
                                    );
                                  },
                                ),
                              ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                                Padding(
                                 padding: EdgeInsets.all(8.0),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text( snapshot.key.toString(),
                                         style: const TextStyle(
                                             fontSize: 18,
                                             fontWeight: FontWeight.bold,
                                             color: Colors.black),),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.only(left: 8),
                                       child: Text("Seat : ${snapshot.child("seat").value.toString()} | Thrust : ${snapshot.child("thrust").value.toString()} | Type : ${snapshot.child("type").value.toString()}",
                                       style: const TextStyle(
                                         fontSize: 12,
                                         color: Colors.black
                                       ),
                                       ),
                                     )
                                   ],
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: ElevatedButton(
                                     onPressed: () {
                                       setState(() {
                                         spaceShipSelected = index;
                                         spaceShipName=snapshot.key.toString();
                                         spaceShipImage = snapshot.child("image").value.toString();
                                         spaceShipType = snapshot.child("type").value.toString();
                                         spaceShipLevel =
                                             int.parse(snapshot.child("level").value.toString());
                                         spaceShipSeat =
                                             int.parse(snapshot.child("seat").value.toString());
                                         spaceShipBase =
                                             int.parse(snapshot.child("base").value.toString());
                                         spaceShipRate =
                                             int.parse(snapshot.child("rate").value.toString());
                                         spaceShipThrust =
                                             int.parse(snapshot.child("thrust").value.toString());
                                       });
                                     rideBookingOTP();
                                 },
                                     style:ButtonStyle(
                                         backgroundColor: MaterialStateProperty.all(mainTheme)
                                     ),
                                     child: const Text("Book now !")),
                               )
                             ],
                           )
                           // columnDetails(snapshot, index, context)
                          ],
                        ),
                      ),
                    );

                    //oldListCard(snapshot, index, context);
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ));
  }

  rideBookingOTP() async{
    // showDialog(
    //     barrierDismissible: false,
    //     context: context,
    //     builder: (BuildContext context)=>LoadingDialog
    //       (messageText: "Confirming your ride"));
    // otp=random.nextInt(9999);
    // setState(() {
    //   generatedOtp=otp;
    // });
    // Map<String,Object> userDataMap={
    //   "otp" : otp
    // };
    // await userRefAuth.update(userDataMap).whenComplete(() => Navigator.pop(context));
    Navigator.push(context, MaterialPageRoute(builder: (c) => const SeatSelection()));
  }
}
