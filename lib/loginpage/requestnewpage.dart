// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasfah/loginpage/loginscreen.dart';
import 'package:wasfah/view/screen/homepage/homepage.dart';

class Requestnewpage extends StatefulWidget {
  const Requestnewpage({super.key});

  @override
  State<Requestnewpage> createState() => _RequestnewpageState();
}

class _RequestnewpageState extends State<Requestnewpage> {
  bool repeat = false;
  late final userid;
  getid() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userid = user.uid;
    }
  }

  late String username;
  String? email;
  String? passWord;
  // String? uid;
  User? checkmail;
  // chackmail() async {
  //   FirebaseAuth.instance.authStateChanges().listen((User? mail) {
  //     if (mail == null) {
  //       print(
  //           'User is currently signed out!=======================================');
  //     } else {
  //       print(
  //           'User is signed in!==============================================');
  //     }
  //   });
  // }
  savedatashared() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("id", userid);
    await pref.setBool('repeat', repeat);
    print("savedData======================================");
  }

  adduserfirestore() async {
    await FirebaseFirestore.instance
        .collection("users")
        .add({"id": userid, "name": username, "fav": [], "admin": false});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            "Login",
            style: TextStyle(
                color: Colors.red[400],
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "User Name",
            ),
            textAlign: TextAlign.end,
            onChanged: (value) {
              username = value;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Mail",
            ),
            textAlign: TextAlign.end,
            onChanged: (value) {
              email = value;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Password",
            ),
            textAlign: TextAlign.end,
            onChanged: (value) {
              passWord = value;
            },
          ),
          const SizedBox(
            height: 30,
          ),
          MaterialButton(
            height: 30,
            color: Colors.red[400],
            child: const Text(
              "add",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              try {
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email!,
                  password: passWord!,
                );
                getid();
                adduserfirestore();
                setState(() {
                  repeat = true;
                });
                await savedatashared();
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(
                        iduser: userid,
                        //  username: username
                      ),
                    ));
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  print('No user found for that email.');
                } else if (e.code == 'wrong-password') {
                  print('Wrong password provided for that user.');
                }
              } catch (e) {
                print("==============================================");
                print(e);
                print("==============================================");
              }
            },
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: MaterialButton(
                  height: 30,
                  color: Colors.teal[400],
                  child: const Text(
                    "Log In",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LogInPage(),
                        ));
                  },
                ),
              ),
            ],
          )
        ],
      ),
    )));
  }
}
