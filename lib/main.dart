import 'package:flutter/material.dart';
import 'package:kelime_ezberlemek/pages/temprory.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Kelime Ezberleme Uygulaması",
      home: TemproryPage(),
    );
  }
}
