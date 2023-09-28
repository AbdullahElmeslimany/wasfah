// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class ReadData extends StatefulWidget {
  const ReadData({super.key});

  @override
  State<ReadData> createState() => _ReadDataState();
}

class _ReadDataState extends State<ReadData> {
  String namecolloction = "users";
  List<QueryDocumentSnapshot> data = [];
  String name = "";
  String? age;
  late bool loading = false;

  getData() async {
    // await FirebaseFirestore.instance
    //     .collection("${namecolloction}").where("age",isEqualTo:  "19")
    //     .get()
    //     .then((QuerySnapshot querySnapshot) {
    //   querySnapshot.docs.forEach((doc) {
    //     setState(() {
    //       // data.add(doc["name"]);
    //       data.addAll(querySnapshot.docs);
    //       loading=false;
    //     });

    //     print("============================================");
    //     print(data);
    //   });
    // });

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(namecolloction)
        .where("age", isEqualTo: "$age")
        .get();

    setState(() {
      data.addAll(querySnapshot.docs);
      loading = false;
    });
    print(data);
  }

  @override
  void initState() {
    // getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (loading == true)
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Expanded(flex: 3,
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Text("${data[index]["name"]}");
                        },
                      ),
                    ),
                    Expanded(flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              age = value;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                            child: const Text("get"),
                            onPressed: () {
                              data.clear();
                              getData();
                              loading = true;
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
