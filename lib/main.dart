// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'my_app_mobile.dart';
import 'my_app_web.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(MyAppMobile());
}
