import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:forecast/forecast/customcity.dart';
import 'package:forecast/forecast/forecast.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? displayText;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textController = TextEditingController();
  List<String> City = [];

  @override
  void initState() {
    super.initState();
    _loadCity();
  }

  Future<void> _loadCity() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      City.add(prefs.getString('city') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Weather Forecast',
          style: TextStyle(
              color: Colors.white, fontFamily: 'Figtree-Regular', fontSize: 24),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Forecast for your city',
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontFamily: 'Figtree-Regular',
                  fontSize: 28),
            ),
          ),
          Container(
            width: 300,
            padding: EdgeInsets.only(top: 20),
            //height: 40,
            child: TextField(
              controller: textController,
              maxLines: null,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                hintText: 'Enter your city',
                hintStyle: const TextStyle(
                    color: Colors.blueGrey,
                    fontFamily: 'Figtree-Regular',
                    fontSize: 22),
              ),
            ),
          ),
          //  ),
          Center(
            child: IconButton(
              onPressed: () {
                setState(() {
                  _addItemToList(textController.text);
                  displayText = textController.text;
                });

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ForecastScreen2()));
              },
              icon: Icon(Icons.cloud),
              iconSize: 100,
              color: Colors.blue,
            ),
          ),
          Text(City.length.toString(),
              style: const TextStyle(
                  fontSize: 34.0, fontFamily: 'Figtree-Regular')),
        ],
      ),
    );
  }

  void _addItemToList(String newItem) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> existingList = prefs.getStringList('city') ?? [];
    existingList.add(newItem);
    await prefs.setStringList('city', existingList);
    setState(() {
      City = existingList;
    });
  }
}
