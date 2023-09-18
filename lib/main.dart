// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'my_app_mobile.dart';
import 'my_app_web.dart';

void main() {
  // runApp(const MyAppMobile());
  // if (kIsWeb) {
  //   runApp(const MyApp());
  // } else {
  //   runApp(const MyAppMobile());
  // }
  runApp(const MyApp());
}

void mountFunction(){
    runApp(const MyApp());
}