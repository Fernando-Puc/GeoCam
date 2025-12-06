import 'package:flutter/material.dart';
import 'package:geo_cam_app/screens/pantallatutorial.dart';
import 'pantallaCK.dart';
import 'pantallaBC.dart';
import 'pantallaDZ.dart';
import 'pantallaNK.dart';

// Pantalla de los municipios
class pantallaprincipal extends StatelessWidget {
  const pantallaprincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 228, 205),
      appBar: AppBar(
        title: const Text('Pantalla Principal'),
        backgroundColor: const Color.fromARGB(255, 196, 14, 14),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => pantallatutorial(context),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            '¡Bienvenido a la Pantalla Principal!',
            style: TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 40,
                childAspectRatio: 2,
                children: [
                  _buildButton(context, "Calkiní", const PantallaCK()),
                  _buildButton(context, "Bécal", const PantallaBC()),
                  _buildButton(context, "Dzitbalché", const PantallaDZ()),
                  _buildButton(context, "Nunkiní", const PantallaNK()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Aquí se controlan los botones
  Widget _buildButton(BuildContext context, String text, Widget screen) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 196, 14, 14),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
