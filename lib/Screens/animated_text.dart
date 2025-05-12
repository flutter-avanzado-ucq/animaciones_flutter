import 'package:flutter/material.dart';

class DelayedFadeTextExample extends StatefulWidget {
  @override
  _DelayedFadeTextExampleState createState() =>
      _DelayedFadeTextExampleState();
}

class _DelayedFadeTextExampleState extends State<DelayedFadeTextExample>
    with TickerProviderStateMixin {  // Usa TickerProviderStateMixin aquí
  List<String> _messages = ['Welcome', 'To', 'Flutter Animations'];
  List<AnimationController> _controllers = [];
  List<Animation<double>> _animations = [];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    for (int i = 0; i < _messages.length; i++) {
      _controllers.add(
        AnimationController(
          duration: Duration(seconds: 1),
          vsync: this,  // Aquí se usa 'this' como TickerProvider
        ),
      );

      _animations.add(
        Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _controllers[i],
            curve: Curves.easeInOut,
          ),
        ),
      );

      // Start animation with delay
      Future.delayed(Duration(milliseconds: 500 * i), () {
        _controllers[i].forward();
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Delayed Fade Text')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _messages.length,
            (index) {
              return FadeTransition(
                opacity: _animations[index],
                child: Text(
                  _messages[index],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
