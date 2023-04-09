import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forecast/home/home.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}
