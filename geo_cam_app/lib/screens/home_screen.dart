import 'package:flutter/material.dart';

//Segunda pantalla
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla Principal'),
        backgroundColor: Color.fromARGB(255, 196, 14, 14),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          '¡Esta es la Pantalla Principal!',
          style: TextStyle(fontSize: 22),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
