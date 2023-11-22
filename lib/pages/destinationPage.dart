import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/commons/common_methods.dart';
import 'package:login/global/global_var.dart';
import 'package:login/pages/destinationDescriptionPage.dart';
import 'package:login/pages/spaceShipCompanies.dart';

class DestinationPage extends StatefulWidget {
  const DestinationPage({super.key});

  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  int index = 0;
  CommonMethods commonMethods = CommonMethods();
  final TextEditingController _setLocation= TextEditingController();
  bool tapped=false;
  onBarItemClicked(int i) {
    setState(() {
      index = i;
      controller!.index = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        width: 255,
        child: Drawer(
          child: ListView(
            children: [
              Container(
                color: Colors.black,
                height: 160,
                child: DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.person),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userName,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xff103232),
      ),
      backgroundColor: const Color(0xff103232),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12)
                ),
                child:Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: TextField(
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black
                    ),
                    controller: _setLocation,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        color: Colors.black,
                        onPressed: () {
                          setState(() {
                            empty=false;
                            currentPlanetName=_setLocation.text.trim().toString();
                          });
                          _setLocation.clear();
                        },
                      ),
                      hintText: empty?" Set your location . . . ":" Location set to $currentPlanetName",
                      hintStyle: const TextStyle(
                        color: Colors.grey
                      ),
                      contentPadding: const EdgeInsets.all(20.0),
                    ),
                  ),
                )),
          ),
          const SizedBox(
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Destinations",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Flexible(
            child: FirebaseAnimatedList(
                //Progress Indicator
                shrinkWrap: true,
                defaultChild: const Center(child: LinearProgressIndicator()),
                query: FirebaseDatabase.instance.ref().root.child("locations"),
                itemBuilder: (context, snapshot, animation, index) {
                  return //newCardView(snapshot);
                  oldCardView(index, snapshot, context);
                }),
          ),
        ],
      ),
    );
  }
  Column oldCardView(int index, DataSnapshot snapshot, BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              setState(() {
                indexLocTapped = index;
                destinationPlanetName=snapshot.key.toString();
                destinationPlanetDetails=snapshot.child("details").value.toString();
                destinationPlanetImage=snapshot.child("image").value.toString();
                destinationPlanetx=int.parse(snapshot.child("x").value.toString());
                destinationPlanety=int.parse(snapshot.child("y").value.toString());
                Navigator.push(context, MaterialPageRoute(builder: (c) => const DestinationDescription()));
              });
            },
            child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                leading: Container(
                  padding: const EdgeInsets.only(right: 12.0),
                  decoration: const BoxDecoration(
                      border: Border(
                          right:
                              BorderSide(width: 1.0, color: Colors.white24))),
                  child: Container(
                    height: 50,
                    width: 50,
                    child: CachedNetworkImage(
                      imageUrl:
                      snapshot.child("image").value.toString(),
                      placeholder: (context, url) =>
                          const LinearProgressIndicator(),
                      imageBuilder: (context, imageprovider) {
                        return Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageprovider, fit: BoxFit.fill)),
                        );
                      },
                    ),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    snapshot.key.toString(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
                subtitle: Row(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(snapshot.child("details").value.toString(),
                            style: const TextStyle(color: Colors.white),
                          overflow: TextOverflow.ellipsis,),
                      ),
                    )
                  ],
                ),))
      ],
    );
  }
}
