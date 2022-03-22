// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:scannerapp/home.dart';

class SuccessPage extends StatefulWidget {
  var amount;
  SuccessPage({Key? key, this.amount}) : super(key: key);

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.only(top: 170),
          child: Center(
            child: Column(
              children: [
                const Icon(
                  Icons.check_circle,
                  size: 200,
                  color: Colors.green,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Thank You!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.green),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Payment done Successfully",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Your repayment amount is $amount",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    dispose();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const MyHomePage()));
                  },
                  child: const Text("HOME"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 15, left: 60, right: 60),
                    primary: Colors.green,
                    onPrimary: Colors.white,
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
