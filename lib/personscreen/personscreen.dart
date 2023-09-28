// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wasfah/loginpage/requestnewpage.dart';

class PersonPage extends StatefulWidget {
  final id;
  final name;
  const PersonPage({super.key, required this.id, required this.name});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  late QuerySnapshot querySnapshot;
  String namecolloction = "users";
  List<QueryDocumentSnapshot> datasave = [];
  String? name;
  late String newPassword;
  bool loading = true;
  bool loadingMail = true;
  User? user;
  late String? email;
  getData() async {
    user = FirebaseAuth.instance.currentUser;
    setState(() {
      email = user!.email;
      // loadingMail = false;
    });

    // await FirebaseAuth.instance
    //     .sendPasswordResetEmail(email: "aelmeslimany24@gmail.com");
  }

  getdatefirebase() async {
    querySnapshot = await FirebaseFirestore.instance
        .collection(namecolloction)
        .where("id", isEqualTo: "${widget.id}")
        .get();

    setState(() {
      datasave.addAll(querySnapshot.docs);
      loading = false;
    });
    print("========================================================");
    print(datasave[0]["name"]);
    print("========================================================");
  }

  deleteAccountFirestore(String idUsersDelet) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        .doc(idUsersDelet)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  @override
  void initState() {
    getdatefirebase();
    getData();
    print(widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: loadingMail == true && loading == true
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "name",
                      ),
                      textAlign: TextAlign.center,
                      initialValue: "${datasave[0]["name"]}",
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      enabled: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "mail",
                      ),
                      textAlign: TextAlign.center,
                      initialValue: "$email",
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Password",
                      ),
                      textAlign: TextAlign.end,
                      onChanged: (value) {
                        setState(() {
                          setState(() {
                            newPassword = value;
                          });
                        });
                      },
                    ),
                    IconButton(
                        onPressed: () async {
                          // print(newPassword);
                          // final user = FirebaseAuth.instance.currentUser;
                          // await user?.updatePassword(newPassword);
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(
                          //         content: Text("تم تغيير كلمة السر بنجاح")));
                        },
                        icon: const Icon(Icons.change_circle)),
                    MaterialButton(
                      onPressed: () async {
                        AwesomeDialog(
                          btnOkText: "حذف",
                          btnCancelText: 'الغاء',
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'حذف هذا الحساب',
                          desc:
                              'هل انت متاكد من انك تريد حذف هذا الحساب لن يتم ارجاعه بعد اتمام عملية الحذف',
                          btnCancelOnPress: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("لم يتم حذف الحساب")));
                          },
                          btnOkOnPress: () async {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("تم حذف الحساب بنجاح")));
                            await user?.delete();
                            deleteAccountFirestore(datasave[0].id);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Requestnewpage(),
                                ));
                          },
                        ).show();
                      },
                      child: Container(
                          height: 30,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.red),
                          child: const Center(
                            child: Text(
                              "Delete Account",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
