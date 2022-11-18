import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_myapp/animation/animation.dart';
import 'package:weather_myapp/provider/weather_provider.dart';
import 'package:weather_myapp/screens/home_screen.dart';
import 'package:weather_myapp/screens/weather_details.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<WeatherProvider>(create: (_) => WeatherProvider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: homeScreen(),
    );
  }
}
