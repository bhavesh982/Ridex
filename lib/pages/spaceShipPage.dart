import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../global/global_var.dart';

class SpaceShipPage extends StatefulWidget {
  const SpaceShipPage({super.key});

  @override
  State<SpaceShipPage> createState() => _SpaceShipPageState();
}

class _SpaceShipPageState extends State<SpaceShipPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: CachedNetworkImage(
                    imageUrl: spaceShipImage,
                    placeholder: (context, url) =>
                        const LinearProgressIndicator(),
                    imageBuilder: (context, imageprovider) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 0,
                                  offset: const Offset(10, 5),
                                  color: Colors.black.withOpacity(0.4))
                            ],
                            image: DecorationImage(
                                image: imageprovider, fit: BoxFit.fill)),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Description : ",
                        style: TextStyle(
                            fontSize: fontTitle, color: Colors.black)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Type : $spaceShipType",
                        style: const TextStyle(
                            fontSize: fontSc, color: Colors.black)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Level : $spaceShipLevel",
                        style: const TextStyle(
                            fontSize: fontSc, color: Colors.black)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Seat : $spaceShipSeat",
                        style: const TextStyle(
                            fontSize: fontSc, color: Colors.black)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Thrust : $spaceShipThrust " "lbs",
                        style: const TextStyle(
                            fontSize: fontSc, color: Colors.black)),
                  ],
                ),
              ),
              const SizedBox(height: 30,),
             Container(
               height: 250,
               child: FirebaseAnimatedList(
                 scrollDirection: Axis.horizontal,
                 query: FirebaseDatabase.instance.ref().child("criminals"),
                 itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                 return Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Container(
                     height: 250,
                     width: 150,
                     color: Colors.blue,
                   ),
                 );
               },
               ),
             )
            ],
          ),
        ));
  }
}

class bountyContent extends StatelessWidget {
  const bountyContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FirebaseAnimatedList(
      scrollDirection: Axis.horizontal,
      defaultChild: const Center(child: LinearProgressIndicator()),
      query: FirebaseDatabase.instance.ref().child("criminals"),
      itemBuilder: (context, snapshot, animation, index) {
        if (snapshot.key.toString() != "logo") {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 4,
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: 350,
                  child: CachedNetworkImage(
                    imageUrl:
                        snapshot.child("mars").child("img").value.toString(),
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
                ListTile(
                  title: Center(
                    child: Text(
                      //company name
                      snapshot.child("mars").key.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 56)),
                    child: const Text(
                      'Book',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
