import 'package:bitaqwa/pages/homePage.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      debugShowCheckedModeBanner: false,
      routes: {
        // '/' nama route dari halam HomePage()
        //'/zakat' nama route dari halan zakat 
        '/': (context) => HomePage(),
      },
    );
  }
}
