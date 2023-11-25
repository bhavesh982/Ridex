import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:login/main.dart';
import 'package:login/pages/spaceShipsList.dart';

import '../commons/common_methods.dart';
import '../global/global_var.dart';


class SpaceShipCompanies extends StatefulWidget {
  const SpaceShipCompanies({ Key? key }) : super(key: key);
  @override
  SpaceShipCompaniesState createState() => SpaceShipCompaniesState();
}
class SpaceShipCompaniesState extends State<SpaceShipCompanies> {
  CommonMethods commonMethods = CommonMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('', style: TextStyle(
          color: Colors.black,
        ),),
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
              "Spacelines",
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
              query: FirebaseDatabase.instance.ref().child("spaceships").child("company"),
              itemBuilder: (context,snapshot,animation,index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffe9e9e9),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    height: 180,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 10),
                          child: Container(
                            height: 140,
                            width: 100,
                            child: CachedNetworkImage(
                              imageUrl:
                              snapshot.child("logo").value.toString(),
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
                        ),
                        const SizedBox(
                          width: 20,
                          height: double.infinity,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20,top: 20),
                              child: Text(
                                snapshot.key.toString(),
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: SizedBox(
                                  width: 160,
                                  height: 30,
                                  ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                height: 35,
                                width: 160,
                                child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        spaceIndexLocTapped=index;
                                        spaceLineName=snapshot.key.toString();
                                      });
                                      Navigator.push(context, MaterialPageRoute(builder: (c)=>const SpaceShipsList()));
                                    },
                                    style:ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(mainTheme)
                                    ),
                                    child: const Text("Book now !")),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
            },
            ),
          ),
        ],
      )
    );
  }

  Card oldCardList(DataSnapshot snapshot, int index, BuildContext context) {
    return Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          elevation: 4,
          child: Column(
            children: [
                Container(
                  height: 200,
                  width: 200,
                  child: CachedNetworkImage(
                    imageUrl: snapshot.child("logo").value.toString(),
                    placeholder:(context,url)=> const LinearProgressIndicator(),
                    imageBuilder: (context,imageprovider){
                      return Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageprovider,
                                fit: BoxFit.fill
                            )
                        ),
                      );
                    },
                  ),
                ),
              ListTile(
                title: Center(
                  child: Text(  //company name
                    snapshot.key.toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                   setState(() {
                     spaceIndexLocTapped=index;
                     //spaceCompanySnaps.add(snapshot.key.toString());
                   });
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>const SpaceShipsList()));
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize:
                      Size(MediaQuery.of(context).size.width, 56)),
                  child: const Text(
                    'Select',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
  }
}