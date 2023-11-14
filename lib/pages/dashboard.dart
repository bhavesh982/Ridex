import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:login/global/global_var.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}


class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin{
  TabController? controller;
  int index=0;
  onBarItemClicked(int i){
    setState(() {
      index=i;
      controller!.index=index;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =TabController(length: 4, vsync: this);
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
                      const SizedBox(height: 20,),

                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(userName,)
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
        title: const Text("Dashboard"),
      ),
      body: FirebaseAnimatedList(
        query: FirebaseDatabase.instance.ref().root.child("owners").child("iEi1xdUN48dDQlnSUpV6BmlzsDD3").child("spaceship").child("images"),
        itemBuilder: (context,snapshot, animation, index) {
                return Column(
                  children: [
                    FadeInImage.assetNetwork(
                        placeholder: 'assets/logo.png',
                        image: snapshot.value.toString())
                  ],

                );
        },
      )
    );
  }
}
