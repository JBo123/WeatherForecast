import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:forecast/home/home.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<ForecastScreen> {
  Map<String, dynamic> _data = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://api.weatherapi.com/v1/current.json?key=7defd4b9f9c14e90bfe93550230904&q=Pardubice&aqi=yes'));
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
          title: Text('Weather Forecast '),
        ),
        body: _data.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_data['location']['name'],
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8.0),
                        Text('Temperature: ${_data['current']['temp_c']}°C'),
                        SizedBox(height: 8.0),
                        Text(
                            'Condition: ${_data['current']['condition']['text']}'),
                        SizedBox(height: 8.0),
                        Text(
                            'Wind Speed: ${_data['current']['wind_kph']} km/h'),
                        SizedBox(height: 8.0),
                        Text('Humidity: ${_data['current']['humidity']}%'),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
