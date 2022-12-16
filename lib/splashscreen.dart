import 'dart:async';

import 'package:flutter/material.dart';
import 'package:homestay_raya/registrationscreen.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key, required user});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const RegistrationScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 120, 49, 93),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text(
              "Homestay Raya",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            CircularProgressIndicator(),
            Text("Latest Version")
          ],
        ),
      ),
    );
  }
}
