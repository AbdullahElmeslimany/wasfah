// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddFireBase extends StatelessWidget {
  const AddFireBase({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    String? name;
    String? password;
    return SafeArea(
        child: Scaffold(
            body: Column(
      children: [
        TextField(
          onChanged: (value) {
            name = value;
          },
        ),
        TextField(
          onChanged: (value) {
            password = value;
          },
        ),
        MaterialButton(
          onPressed: () async {
            print(name);
            print(password);
            users
                .add({"name": name, "password": password})
                .then((value) => print("User Added"))
                .catchError((error) => print("Failed to add user: $error"));
          },
          child: const Text("add"),
        )
      ],
    )));
  }
}
