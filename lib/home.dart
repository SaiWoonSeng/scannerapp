import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:scannerapp/model/user_model.dart';
import 'package:scannerapp/success_page.dart';

// ignore: non_constant_identifier_names

String? amount;

TextEditingController cNoController = TextEditingController();

TextEditingController cNameController = TextEditingController();

TextEditingController cphNoController = TextEditingController();

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var auth = FirebaseAuth.instance.currentUser;
  UserModel userModel = UserModel();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("User")
        .doc(auth!.uid)
        .get()
        .then((value) => userModel = UserModel.fromMap(value.data()));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: const Text("Scanner App"),
      ),
      body: cNameController.text.isNotEmpty
          ? AlertDialog(
              title: const Text('Collection Loan'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: cNoController,
                      enabled: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('CustomerNo'),
                      ),
                      onChanged: (value) {
                        setState(() {
                          value = cNoController.value.text;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: cNameController,
                      enabled: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('CustomerName'),
                      ),
                      onChanged: (value) {
                        setState(() {
                          value = cNameController.value.text;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: cphNoController,
                      enabled: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('PhoneNo'),
                      ),
                      onChanged: (value) {
                        setState(() {
                          value = cphNoController.value.text;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Amount',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Amount';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          amount = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    saveData(
                        cNoController.value.text,
                        cNameController.value.text,
                        cphNoController.value.text,
                        amount!,
                        userModel.userNo.toString(),
                        DateTime.now());
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SuccessPage(amount: amount)));
                    cNameController.clear();
                    cNoController.clear();
                    cphNoController.clear();
                  },
                  child: const Text("Save"),
                ),
                ElevatedButton(
                  onPressed: () {
                    cNameController.clear();

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage()));
                  },
                  child: const Text(
                    "Cancle",
                    // style: TextStyle(color: Colors.amber),
                  ),
                )
              ],
            )
          : const Center(
              child: Text("Make scan to collect payment",
                  style: TextStyle(
                      color: Color.fromARGB(255, 18, 20, 5),
                      fontSize: 18,
                      fontWeight: FontWeight.bold))),

      floatingActionButton: FloatingActionButton(
        onPressed: scanresult,
        child: const Icon(Icons.qr_code_outlined, size: 20),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  //scanner
  void scanresult() async {
    var cameraStatus = await Permission.camera.status;
    if (cameraStatus.isGranted) {
      String? cameraScanResult = await scanner.scan();
      setState(() {
        List<String> splitedText = cameraScanResult!.split(":");
        cNoController.text = splitedText[0];
        cNameController.text = splitedText[1];
        cphNoController.text = splitedText[2];
      });
    } else {
      var isGrant = await Permission.camera.request();
      if (isGrant.isGranted) {
        String? cameraScanResult = await scanner.scan();
        setState(() {
          List<String> splitedText = cameraScanResult!.split(":");
          cNoController.text = splitedText[0];
          cNameController.text = splitedText[1];
          cphNoController.text = splitedText[2];
        });
      }
    }
  }

  void saveData(String cno, String cname, String phno, String? amount,
      String loID, DateTime collectDate) {
    var dbRef = FirebaseFirestore.instance;
    dbRef.collection("CollectRepayment").doc().set({
      'cNo': cno,
      'Name': cname,
      'phno': phno,
      'amount': amount,
      'CollectDate': collectDate,
      'LOId': loID
    });
  }

  // //SentMessage
  // void sendingSMS(String msg, List<String> listReceipents) async {
  //   String sendResult = await sendSMS(message: msg, recipients: listReceipents)
  //       .catchError((err) {
  //     print(err);
  //   });
  //   print(sendResult);
  // }
}
