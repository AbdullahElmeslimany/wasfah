// ignore_for_file: avoid_print, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print(
            'User is currently signed out!=======================================');
      } else {
        print(
            'User is signed in!==============================================');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? mail;
    String? password;

    return SafeArea(
        child: Scaffold(
            body: Column(
      children: [
        TextField(
          onChanged: (value) {
            mail = value;
          },
        ),
        TextField(
          onChanged: (value) {
            password = value;
          },
        ),
        MaterialButton(
          child: const Text("add"),
          onPressed: () async {
            try {
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                print('The password provided is too weak.');
              } else if (e.code == 'email-already-in-use') {
                print('The account already exists for that email.');
              }
            } catch (e) {
              print(e);
            }
          },
        )
      ],
    )));
  }
}
