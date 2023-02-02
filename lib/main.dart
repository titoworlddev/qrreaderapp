import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:qrreaderapp/src/pages/home_page.dart';
import 'package:qrreaderapp/src/pages/mapa_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRReader',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => const HomePage(),
        'mapa': (BuildContext context) => const MapaPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
      ),
    );
  }
}
