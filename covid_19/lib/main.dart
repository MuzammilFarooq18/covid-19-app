import 'package:flutter/material.dart';
import 'package:covid_19/splash_screen.dart';

void main() {
  runApp(const covid_app());
}

class covid_app extends StatelessWidget {
  const covid_app({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splash_screen(),
    );
  }
}
