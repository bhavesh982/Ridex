import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:login/global/global_var.dart';
import 'package:login/pages/spaceShipCompanies.dart';
class DestinationDescription extends StatefulWidget {
  const DestinationDescription({super.key});

  @override
  State<DestinationDescription> createState() => _DestinationDescriptionState();
}

class _DestinationDescriptionState extends State<DestinationDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: mainTheme,
      ),
      backgroundColor: mainTheme,
      body:   Padding(
        padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xff0A7F7F),
              borderRadius: BorderRadius.circular(12)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height/9,  //Planet and text distance
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
                                width: MediaQuery.of(context).size.width/6.5,       //Planet width
                                height: MediaQuery.of(context).size.height/9,       //Planet height
                                child: CachedNetworkImage(
                                  imageUrl:
                                  destinationPlanetImage,
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
                            title: Text(
                              destinationPlanetName,
                              style: const TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
                           ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8,right: 8),
                        child: Container(height: MediaQuery.of(context).size.height/4,  //Text area
                        child: Flexible(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8,right: 8),
                              child: Text(destinationPlanetDetails,style: const TextStyle(color: Colors.white),),
                            ),
                          ),
                        ),),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text("Available Bounties ",style:
                    TextStyle(
                      fontSize: 20,
                    ),),
                ),
                const SizedBox(height: 10,),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Flexible(
                        child: Container(
                          height: MediaQuery.of(context).size.height/4, //Available bounties height
                            child: FirebaseAnimatedList(
                              shrinkWrap: true,
                              defaultChild: const Center(child: CircularProgressIndicator()),
                              scrollDirection: Axis.horizontal,
                              query: FirebaseDatabase.instance.ref().root.child("criminals").child(destinationPlanetName),
                              itemBuilder: (context,snapshot, animation, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width/3,   //Bounties  box size
                                    decoration: BoxDecoration(
                                      color: const Color(0xff185151),
                                      borderRadius: BorderRadius.circular(12)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Container(
                                            height: 120,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                              snapshot.child("img").value.toString(),
                                              placeholder: (context, url) =>
                                              const LinearProgressIndicator(),
                                              imageBuilder: (context, imageprovider) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(12),
                                                      image: DecorationImage(
                                                          image: imageprovider, fit: BoxFit.fill)),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Name : ${snapshot.key.toString()}"),
                                              const SizedBox(height: 5,),
                                              Text("Prize : ${snapshot.child("prize").value.toString()}"),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30,right: 30),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (c)=>const SpaceShipCompanies()));
                        },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(mainTheme)
                            ),
                            child: const Text("Lets go")),
                      ),
                    ),
                    const SizedBox(height: 10,)
                  ],
                )
              ],
            ),
          ), //edit
        ),
      ),

    );
  }
}
