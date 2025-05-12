import 'package:animaciones_flutter/Screens/navigation_animation_example.dart';
import 'package:flutter/material.dart';

import 'Screens/animated_boton.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BouncingButtonExample(),
    );
  }
}
