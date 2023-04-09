import 'dart:convert';
import 'package:http/http.dart' as http;

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
