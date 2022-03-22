import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scannerapp/home.dart';
import 'package:scannerapp/register_user.dart';

late String _email, _password;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var authInstance = FirebaseAuth.instance;

  loginUser() async {
    if (_formKey.currentState!.validate()) {
      await authInstance
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((value) {
        Fluttertoast.showToast(
            msg: 'Login Successful',
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.green,
            textColor: Colors.white);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MyHomePage()));
        // ignore: invalid_return_type_for_catch_error
      }).catchError((e) => Fluttertoast.showToast(
              msg: e.message,
              backgroundColor: Colors.red,
              gravity: ToastGravity.TOP,
              textColor: Colors.white));
    }
  }

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
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => _email = value,
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
                  onChanged: (value) => _password = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter password';
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
                ElevatedButton(
                  onPressed: () {
                    loginUser();
                  },
                  child: const Text("Login"),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Registeruser(),
                          ));
                    },
                    child: const Text("Create Account "))
              ],
            ),
          ),
        )),
      ),
    );
  }
}
