import 'package:flutter/material.dart';
import 'package:scannerapp/splash_screen.dart';

String? result;
List<String> splitedText = result!.split(":");

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const SplashScreen(),
    );
  }
}
