import 'package:flutter/material.dart';
import 'package:covid_19/search_screen.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Positioned(
              top: 312,
              right: 2,
              left: 2,
              child: Image.asset('assets/images/corona.png')),
          const Positioned(
              top: 542,
              left: 67,
              child: Text(
                'Be Aware and Stay Safe',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
              )),
          Positioned(
              top: 710,
              left: 220,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(
                        top: 20, bottom: 20, left: 30, right: 30),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => search_screen(),
                      ),
                    );
                  },
                  child: const Text('Get Started',
                      style: TextStyle(color: Colors.white)))),
        ]));
  }
}
