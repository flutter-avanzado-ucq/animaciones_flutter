import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _showText = false;

  @override
  void initState() {
    super.initState();

    // Crear el AnimationController para las animaciones
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // Animación de escala (crecer el logo)
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Iniciar la animación
    _controller.forward().whenComplete(() {
      // Mostrar el texto después de completar la animación del logo
      setState(() {
        _showText = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void navigateToNextScreen(BuildContext context) {
    // Navegar a la siguiente pantalla (puedes personalizarla)
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NextScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo con animación de escala
            ScaleTransition(
              scale: _scaleAnimation,
              child: Image.asset(
                'assets/logo_Liliana.jpg', // Cambia por el logo que deseas
                width: 150,
                height: 150,
              ),
            ),
            // Espacio entre el logo y el texto
            SizedBox(height: 20),
            // Texto con animación de opacidad
            AnimatedOpacity(
              opacity: _showText ? 1.0 : 0.0,
              duration: Duration(seconds: 2),
              child: Text(
                'Bienvenido a la App',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Espacio entre el texto y el botón
            SizedBox(height: 40),
            // Botón para navegar a la siguiente pantalla
            ElevatedButton(
              onPressed: () => navigateToNextScreen(context),
              child: Text('Comenzar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Siguiente Pantalla')),
      body: Center(child: Text('Bienvenido a la siguiente pantalla')),
    );
  }
}
