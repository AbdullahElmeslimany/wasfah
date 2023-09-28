// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetDataId extends StatefulWidget {
  const GetDataId({super.key});

  @override
  State<GetDataId> createState() => _GetDataIdState();
}

class _GetDataIdState extends State<GetDataId> {
  // late final ref;
  String id = "TVdDvXJ94ZxARPRm1lOw";
  String name = "users";
  var data;
  final _random = new Random();

  late List listData = [];

  // getdata() async {
  //   ref = await FirebaseFirestore.instance.collection(name).doc(id).get();
  //   setState(() {
  //     data = ref;
  //   });
  // }
  getdata() async {
    QuerySnapshot ref = await FirebaseFirestore.instance.collection(name).get();
    setState(() {
      listData.addAll(ref.docs);
      
    });
    // List<String> list = ['a', 'b', 'c', 'd', 'e'];
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: listData == null
            ? const CircularProgressIndicator()
            : Container(
                height: 300,
                child: ListView.builder(
                  itemCount: listData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(listData[index]["name"]
                        [_random.nextInt(listData.length)]);
                    Text(listData[index]["name"]);
                  },
                ),
              ),
      ),
    ));
  }
}
