import 'package:flutter/material.dart';
import 'package:ng_companion/pages/dashboard.dart';

class MyAppMobile extends StatefulWidget {
  const MyAppMobile({super.key});

  @override
  State<MyAppMobile> createState() => _MyAppMobileState();
}

class _MyAppMobileState extends State<MyAppMobile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iFrish',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: Dashboard(),
    );
  }
}
