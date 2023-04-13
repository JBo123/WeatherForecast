import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:forecast/data/data.dart';
import 'package:forecast/home/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForecastScreen2 extends StatefulWidget {
  const ForecastScreen2({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<ForecastScreen2> {
  Map<String, dynamic> _data = {};
  String City = 'Pardubice';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://api.weatherapi.com/v1/current.json?key=7defd4b9f9c14e90bfe93550230904&q=${displayText}&aqi=yes'));
    final responseData = json.decode(response.body);
    setState(() {
      _data = responseData;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth * 0.9;
    final screenHeight = MediaQuery.of(context).size.height;
    final containerHeight = screenHeight / 2;
    return Scaffold(
      body: _data.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: loadImage(
                      condition: _data['current']['condition']['text']),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Container(
                    height: containerHeight,
                    width: containerWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.lightBlue.withOpacity(0.2),
                          Colors.blue.withOpacity(0.5),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 20.0, top: 20.0),
                          child: Text(_data['location']['name'],
                              style: const TextStyle(
                                  fontSize: 42.0,
                                  fontFamily: 'Figtree-ExtraBold')),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${_data['current']['temp_c']}°C',
                                  style: const TextStyle(
                                      fontSize: 26.0,
                                      fontFamily: 'Figtree-Regular')),
                              //    Icon(Icons.wb_sunny, size: 50.0)
                            ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                  'Condition: ${_data['current']['condition']['text']}',
                                  style: const TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: 'Figtree-Regular')),
                            ),
                            // if (_data['current']['condition']['text'] == 'Cloudy')
                            //   Icon(Icons.cloud, size: 40.0)
                            // else if (_data['current']['condition']['text'] ==
                            //     'Sunny')
                            //   Icon(Icons.sunny, size: 40.0)
                            // else if (_data['current']['condition']['text'] ==
                            //     'Clear')
                            //   Icon(Icons.clear, size: 40.0)
                            // else if (_data['current']['condition']['text'] ==
                            //     'Overcast')
                            //   Icon(Icons.cloud, size: 40.0)
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                      'Wind Speed: ${_data['current']['wind_kph']} km/h',
                                      style: const TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: 'Figtree-Regular'))),
                              // if (_data['current']['wind_kph'] < 5)
                              //   Icon(Icons.air_sharp, size: 20.0)
                              // else if (_data['current']['wind_kph'] > 5 &&
                              //     _data['current']['wind_kph'] < 10)
                              //   Icon(Icons.air_sharp, size: 35.0)
                              // else if (_data['current']['wind_kph'] > 10)
                              //   Icon(Icons.air_sharp, size: 50.0),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                    'Humidity: ${_data['current']['humidity']}%',
                                    style: const TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'Figtree-Regular')),
                              ),
                              // if (_data['current']['humidity'] < 50)
                              //   Icon(Icons.water_drop_outlined, size: 40.0)
                              // else if (_data['current']['humidity'] > 50)
                              //   Icon(Icons.water_drop, size: 40.0),
                            ]),

                        //  ),
                        ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(40.0),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 0, 118, 215)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                            );
                          },
                          child: Text('Change City'),
                        ),
                        //  Image.asset('assets/partlyCloudy.jpg')
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
