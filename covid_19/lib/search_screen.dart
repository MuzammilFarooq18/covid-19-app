import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class search_screen extends StatefulWidget {
  const search_screen({super.key});

  @override
  State<search_screen> createState() => _search_screenState();
}

class _search_screenState extends State<search_screen> {
  final TextEditingController _countryController = TextEditingController();
  Map<String, dynamic> _covidData = {};
  bool _loading = false;
  String _errorMessage = '';

  Future<void> _fetchCovidData(String countryName) async {
    setState(() {
      _loading = true;
      _errorMessage = '';
    });

    String url = 'https://disease.sh/v3/covid-19/countries/$countryName';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          _covidData = json.decode(response.body);
          _loading = false;
        });
      } else {
        setState(() {
          _loading = false;
          _errorMessage = 'Failed to load(${response.statusCode})';
        });
      }
    } catch (e) {
      setState(() {
        _loading = false;
        _errorMessage = 'An error occurred: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'COVID-19 INFORMATION',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(1)),
            Container(
              margin: EdgeInsets.only(right: 20, left: 20),
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 219, 218, 218),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.black),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _countryController,
                      decoration: InputDecoration(
                        hintText: 'Enter country name',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      String country = _countryController.text;
                      _fetchCovidData(country);
                    },
                    child: Icon(Icons.arrow_forward, color: Colors.black),
                  ),
                ],
              ),
            ),
            if (_loading)
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              )
            else if (_errorMessage.isNotEmpty)
              Text(_errorMessage)
            else if (_covidData.isNotEmpty)
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 60, // Adjust height as needed
                      child: Center(
                        child: Text(
                          'Coronavirus Cases: ${_covidData['cases']}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 60, // Adjust height as needed
                      child: Center(
                        child: Text(
                          'Deaths: ${_covidData['deaths']}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 60, // Adjust height as needed
                      child: Center(
                        child: Text(
                          'Recovered: ${_covidData['recovered']}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                      height: 60, // Adjust height as needed
                      child: Center(
                        child: Text(
                          'Active: ${_covidData['active']}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}










  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'COVID-19 INFORMATION',
//             style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
//           ),
//         ),
//         body: SingleChildScrollView(
//             child: Column(children: [
//           Padding(padding: EdgeInsets.all(1)),
//           Container(
//             margin: EdgeInsets.only(right: 20, left: 20),
//             padding: EdgeInsets.all(4),
//             decoration: BoxDecoration(
//               color: Color.fromARGB(255, 219, 218, 218),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Row(
//               children: [
//                 Icon(Icons.search, color: Colors.black),
//                 SizedBox(width: 10),
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Enter city name',
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     String city = _cityController.text;
//                     _fetchCovidInfo(city);
//                   },
//                   child: Icon(Icons.arrow_forward, color: Colors.black),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 40,
//           ),
//           Container(
//             padding: EdgeInsets.all(25),
//             color: const Color.fromARGB(255, 105, 211, 108),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.only(left: 0),
//                   child: Text(
//                     'Coronavirus Cases : ',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   _coronavirusCases,
//                   style: TextStyle(
//                     color: Colors.green,
//                     fontSize: 23,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 70,
//           ),
//           Container(
//             padding: EdgeInsets.all(25),
//             color: const Color.fromARGB(255, 105, 211, 108),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(left: 0),
//                   child: Text(
//                     'Recovered',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   _recovered,
//                   style: TextStyle(
//                     color: Colors.green,
//                     fontSize: 23,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 70,
//           ),
//           Container(
//             padding: EdgeInsets.all(25),
//             color: const Color.fromARGB(255, 105, 211, 108),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(left: 0),
//                   child: Text(
//                     'Infected',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   _infected,
//                   style: TextStyle(
//                     color: Colors.green,
//                     fontSize: 23,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 70,
//           ),
//           Container(
//             padding: EdgeInsets.all(25),
//             color: const Color.fromARGB(255, 105, 211, 108),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(left: 0),
//                   child: Text(
//                     'Deaths: ',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   _deaths,
//                   style: TextStyle(
//                     color: Colors.green,
//                     fontSize: 23,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ])));
//   }
// }
