import 'package:flutter/material.dart';

import 'Screens/animation_controller_example.dart';

void main() {
  runApp(AnimacionesDemoApp());
}

class AnimacionesDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animaciones',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AnimationControllerExample(),
    );
  }
}

class AnimacionesHome extends StatefulWidget {
  @override
  _AnimacionesHomeState createState() => _AnimacionesHomeState();
}

class _AnimacionesHomeState extends State<AnimacionesHome>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    _sizeAnimation = Tween<double>(begin: 100, end: 200)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleSimpleAnimation() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void startAdvancedAnimation() {
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animaciones en Flutter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('1. AnimatedContainer & AnimatedOpacity',
                style: TextStyle(fontWeight: FontWeight.bold)),
            AnimatedContainer(
              duration: Duration(milliseconds: 600),
              width: isExpanded ? 200 : 100,
              height: isExpanded ? 200 : 100,
              color: isExpanded ? Colors.blue : Colors.red,
              curve: Curves.easeInOut,
            ),
            AnimatedOpacity(
              opacity: isExpanded ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: Text('¡Hola animación!'),
            ),
            ElevatedButton(
              onPressed: toggleSimpleAnimation,
              child: Text('Alternar animación simple'),
            ),
            Divider(height: 32),
            Text('2. AnimationController + Tween',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              width: _sizeAnimation.value,
              height: _sizeAnimation.value,
              color: Colors.green,
            ),
            ElevatedButton(
              onPressed: startAdvancedAnimation,
              child: Text('Iniciar animación avanzada'),
            ),
          ],
        ),
      ),
    );
  }
}
