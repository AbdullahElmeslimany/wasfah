// import 'package:cloud_firestore/cloud_firestore.dart';
// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasfah/constant/const.dart';
import 'package:wasfah/loginpage/loginscreen.dart';
import 'package:wasfah/personscreen/personscreen.dart';
import 'package:wasfah/testapp/testtextfild.dart';
import 'package:wasfah/testapp/username.dart';
import 'package:wasfah/view/screen/homepage/categories.dart';
import 'package:wasfah/view/screen/homepage/recommedation.dart';
import 'package:wasfah/view/screen/homepage/search.dart';

class MyHomePage extends StatefulWidget {
  final String iduser;
  // final String username;
  const MyHomePage({super.key, required this.iduser});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? idshared;
  bool? repeatshared;
  QuerySnapshot? getuser;
  ConnectivityResult? connectivityResult;
  List data = [];
  getdatefirebase() async {
    getuser = await FirebaseFirestore.instance
        .collection("users")
        .where("id", isEqualTo: widget.iduser)
        .get();
    setState(() {
      data.addAll(getuser!.docs);
    });
  }

  getDataShared() async {
    SharedPreferences prefget = await SharedPreferences.getInstance();
    idshared = prefget.getString("id");
    repeatshared = prefget.getBool('repeat');
    print("===============================================");
    print(idshared);
    print(repeatshared);
    print("===============================================");
  }

  checkinternet() async {
    connectivityResult = await (Connectivity().checkConnectivity());
  }

  @override
  void initState() {
    getdatefirebase();
    // checkinternet();
    super.initState();
    print("===============================================");
    // print(data[0]["name"]);
    getDataShared();
    print("===============================================");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   actions: [EndDrawerButton(onPressed: () => DropdownButton(items: , onChanged: onChanged),)],
        // ),
        body: getuser == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                ),
                                child: InkWell(
                                  onDoubleTap: () {
                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //     builder: (context) => RecipePage(),
                                    //   ),
                                    // );
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "Hello, ${data[0]["name"]}",
                                        // "Hello, ${data[0]["name"]}",
                                        style: TextStyle(
                                            color: Colors.grey[400],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      StreamBuilder(
                                        stream: Connectivity()
                                            .onConnectivityChanged,
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          return Container(
                                            height: 10,
                                            width: 10,
                                            decoration: BoxDecoration(
                                              color: snapshot.data ==
                                                      ConnectivityResult.none
                                                  ? Colors.grey
                                                  : Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Text(
                                "What Would you Like \n To Cook ToDay?",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomeScreen()),
                                );
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () async {
                                        SharedPreferences pref =
                                            await SharedPreferences
                                                .getInstance();
                                        await pref.remove("id");
                                        await pref.remove("repeat");
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const LogInPage(),
                                            ));
                                      },
                                      child: const Icon(
                                          Icons.exit_to_app_rounded)),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  // const AddPageAdmin(),
                                                  PersonPage(
                                                    id: widget.iduser,
                                                    name: data[0]["name"],
                                                  )));
                                    },
                                    onDoubleTap: () {
                                      if (data[0]["admin"] == true) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    // const AddPageAdmin(),
                                                      const TextfieldTest()));
                                      } else {
                                        PersonPage(
                                          id: widget.iduser,
                                          name: data[0]["name"],
                                        );
                                      }
                                    },
                                    child: const Icon(
                                      Icons.account_circle_rounded,
                                      size: 70,
                                      // color: Colors.teal[700],
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 20),
                      const SearchBarHome(),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Categories",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: InkWell(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           const AddFireBase()),
                                // );
                              },
                              child: Text("See all",
                                  style: TextStyle(
                                      color: basicColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Categories(),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Divider(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Recommendation",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: InkWell(
                              onTap: () {},
                              child: Text("See all",
                                  style: TextStyle(
                                      color: basicColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ),
                          )
                        ],
                      ),
                      const RecommendationState(),
                      // SizedBox(height: 5),

                      const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Divider(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Recipes Of The Weak",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: InkWell(
                              onTap: () async {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => const ReadData(),
                                //     ));
                              },
                              child: Text("See all",
                                  style: TextStyle(
                                      color: basicColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
