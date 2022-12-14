import 'package:flutter/material.dart';
import 'package:sdk/screens/home_screen.dart';
import 'package:sdk/screens/loading_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget  {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      initialRoute: LoadingScreen.id,
      routes: {
        LoadingScreen.id: (context) => LoadingScreen(),
        // HomeScreen.id: (context) => HomeScreen()

      },
    );
  }
}

