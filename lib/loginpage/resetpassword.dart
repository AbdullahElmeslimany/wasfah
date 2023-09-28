// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wasfah/loginpage/loginscreen.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    String? email;
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          MaterialButton(
            height: 30,
            color: Colors.teal[400],
            child: const Text(
              "Send Password For Email",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("تم ارسال رسالة الي البريد الالكتروني")));
              await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LogInPage(),
                  ));
            },
          ),
        ],
      )),
    );
  }
}
