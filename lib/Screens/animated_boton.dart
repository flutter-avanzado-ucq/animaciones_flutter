import 'package:flutter/material.dart';

class BouncingButtonExample extends StatefulWidget {
  @override
  _BouncingButtonExampleState createState() => _BouncingButtonExampleState();
}

class _BouncingButtonExampleState extends State<BouncingButtonExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bouncing Button')),
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Click Me'),
          ),
        ),
      ),
    );
  }
}
