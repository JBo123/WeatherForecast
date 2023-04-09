import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:forecast/forecast/customcity.dart';
import 'package:forecast/forecast/forecast.dart';

String? displayText;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 108, 0, 127),
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
                  color: Color.fromARGB(255, 108, 0, 127),
                  fontFamily: 'Figtree-Regular',
                  fontSize: 28),
            ),
          ),
          Container(
            width: 200,
            margin: EdgeInsets.only(top: 30),
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1.5,
                    style: BorderStyle.solid,
                    color: Colors.black12),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            child: TextField(
              controller: textController,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Enter your city',
                hintStyle: TextStyle(
                    color: Color.fromARGB(255, 108, 0, 127),
                    fontFamily: 'Figtree-Regular',
                    fontSize: 24),
              ),
            ),
          ),
          Center(
            child: IconButton(
              onPressed: () {
                setState(() {
                  displayText = textController.text;
                });
                if (displayText != null) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForecastScreen2()));
                }
              },
              icon: Icon(Icons.cloud),
              iconSize: 100,
              color: Color.fromARGB(255, 108, 0, 127),
            ),
          ),
        ],
      ),
    );
  }
}
