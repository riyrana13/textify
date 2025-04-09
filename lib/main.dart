import 'package:flutter/material.dart';
import 'screens/ocr_screen.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Textify',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const OCRScreen(),
    );
  }
}
