import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//Future<Map<String, dynamic>>
// Future<Map<String, dynamic>> fetchData() async {
//   final response = await http.get(Uri.parse(
//       'https://api.open-meteo.com/v1/forecast?latitude=50.03&longitude=15.79&hourly=temperature_2m,rain&daily=temperature_2m_max,temperature_2m_min,rain_sum&timezone=Europe%2FBerlin'));

//   if (response.statusCode == 200) {
//     // The API returns JSON data, so we decode it using the jsonDecode function.
//     return jsonDecode(response.body);
//   } else {
//     throw Exception('Failed to fetch data');
//   }
// }

Future<Map<String, dynamic>> fetchData() async {
  final response = await http.get(Uri.parse('https://example.com/api/data'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    // Now you can use the `data` object as a `Map<String, dynamic>`
    // to access the properties of the JSON data.
    return data;
  } else {
    throw Exception('Failed to fetch data');
  }
}

AssetImage loadImage({required String condition}) {
  if (condition == 'Cloudy' || condition == 'Overcast')
    return const AssetImage('assets/cloud.jpg');
  else if (condition == 'Sunny' || condition == 'Clear')
    return const AssetImage('assets/sun.jpg');
  else if (condition == 'Rainyr' || condition == 'Light rain')
    return const AssetImage('assets/rain.jpg');
  else
    return const AssetImage('assets/Background.png');
}

AssetImage _getImage(String condition) {
  // String condition = _data['current']['condition']['text'];
  if (condition == 'Sunny' || condition == 'Clear') {
    return const AssetImage('assets/sun.jpg');
  } else if (condition == 'Cloudy' || condition == 'Overcast') {
    return AssetImage('assets/cloud.jpg');
  } else if (condition == 'Rainy') {
    return AssetImage('assets/rainy.jpg');
  } else {
    return AssetImage('assets/Background.jpg');
  }
}

Future<void> getCity() async {
  final prefs = await SharedPreferences.getInstance();
  String city = prefs.getString('city') ?? '';
  // return city;
}
