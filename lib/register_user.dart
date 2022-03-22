import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:scannerapp/login_screen.dart';
import 'package:scannerapp/model/user_model.dart';

// ignore: unused_element

var authInstance = FirebaseAuth.instance;

class Registeruser extends StatefulWidget {
  const Registeruser({Key? key}) : super(key: key);

  @override
  State<Registeruser> createState() => _RegisteruserState();
}

class _RegisteruserState extends State<Registeruser> {
  TextEditingController userNo = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController comfirmpassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
            child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  onChanged: (value) => userNo.text = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter UserNo';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('UserNo'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (value) => userName.text = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter UserName';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('UserName'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => email.text = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Email'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  onChanged: (value) => password.text = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter password';
                    } else if (password.text.length < 8) {
                      return 'your password should have 8';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Password'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  onChanged: (value) => comfirmpassword.text = value,
                  validator: (value) {
                    if (value != password.text) {
                      return 'Please check your confirmPassword';
                    }
                    if (value!.isEmpty) {
                      return 'Please Enter ConfirmPassword';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('ConfirmPassword'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      registerUser(email.text, password.text);
                    }
                  },
                  child: const Text("Register"),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Future<void> registerUser(String email, String passwrod) async {
    await authInstance
        .createUserWithEmailAndPassword(email: email, password: passwrod)
        .then((value) => postDetailsUser())
        .catchError((e) => Fluttertoast.showToast(msg: e.message));
  }

  postDetailsUser() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    User? user = authInstance.currentUser;
    UserModel userModel = UserModel();

    userModel.userNo = userNo.text;
    userModel.userName = userName.text;
    userModel.email = user!.email;
    userModel.uID = user.uid;

    await firestore.collection("User").doc(user.uid).set(userModel.toMap());
    Fluttertoast.showToast(msg: 'Create Account Successful');
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route<dynamic> roune) => false);
  }
}
