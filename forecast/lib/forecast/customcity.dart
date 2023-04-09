import 'dart:convert';
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
    return MaterialApp(
      title: 'HTTP Request',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 108, 0, 127),
          title: Text('Weather Forecast '),
        ),
        body: _data.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Align(
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Column(
                    children: [
                      Text(_data['location']['name'],
                          style: const TextStyle(
                              fontSize: 40.0, fontFamily: 'Figtree-Regular')),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Temperature: ${_data['current']['temp_c']}°C',
                                style: const TextStyle(
                                    fontSize: 24.0,
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
                          if (_data['current']['condition']['text'] == 'Cloudy')
                            Icon(Icons.cloud, size: 40.0)
                          else if (_data['current']['condition']['text'] ==
                              'Sunny')
                            Icon(Icons.sunny, size: 40.0)
                          else if (_data['current']['condition']['text'] ==
                              'Clear')
                            Icon(Icons.clear, size: 40.0)
                          else if (_data['current']['condition']['text'] ==
                              'Overcast')
                            Icon(Icons.cloud, size: 40.0)
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
                            if (_data['current']['wind_kph'] < 5)
                              Icon(Icons.air_sharp, size: 20.0)
                            else if (_data['current']['wind_kph'] > 5 &&
                                _data['current']['wind_kph'] < 10)
                              Icon(Icons.air_sharp, size: 35.0)
                            else if (_data['current']['wind_kph'] > 10)
                              Icon(Icons.air_sharp, size: 50.0),
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
                            if (_data['current']['humidity'] < 50)
                              Icon(Icons.water_drop_outlined, size: 40.0)
                            else if (_data['current']['humidity'] > 50)
                              Icon(Icons.water_drop, size: 40.0),
                          ]),

                      //  ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.purple),
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
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
