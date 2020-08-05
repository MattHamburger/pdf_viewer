import 'dart:io';

import 'package:flutter/material.dart';

import 'drawer_for_examples.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = AppHttpOverrides();
  runApp(DrawerForExamples());
}

class AppHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        // print('Hiding Error');
        return true;
      };
  }
}
