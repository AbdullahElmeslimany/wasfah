// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasfah/loginpage/requestnewpage.dart';
import 'package:wasfah/loginpage/resetpassword.dart';
import 'package:wasfah/view/screen/homepage/homepage.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  String? email;
  String? passWord;
  String? uid;
  bool repeat = false;
  List data = [];

  savedatashared() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("id", uid!);
    await pref.setBool('repeat', repeat);
    print("savedData======================================");
  }

  getprofial() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: passWord!);
      print('==========================================');
      print('scusses login');
      uid = FirebaseAuth.instance.currentUser!.uid;
      print(uid);
      QuerySnapshot getdata = await FirebaseFirestore.instance
          .collection("users")
          .where("id", isEqualTo: uid)
          .get();
      setState(() {
        data.addAll(getdata.docs);

        repeat = true;
      });
      await savedatashared();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(
              iduser: uid!,
              // username: data[0]["name"]
            ),
          ));
      print(data[0]["name"]);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                  height: 30,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  ),
                  textAlign: TextAlign.end,
                  onChanged: (value) {
                    email = value;
                  },
                ),
                const SizedBox(
                  height: 30,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        child: MaterialButton(
                          child: const Text(
                            "Reset Password",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ResetPassword(),
                                ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.red[400],
                  ),
                  width: MediaQuery.sizeOf(context).width - 30,
                  child: MaterialButton(
                    height: 30,
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      getprofial();
                    },
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width - 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.teal[400],
                        ),
                        child: MaterialButton(
                          child: const Text(
                            "New User",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Requestnewpage(),
                                ));
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
