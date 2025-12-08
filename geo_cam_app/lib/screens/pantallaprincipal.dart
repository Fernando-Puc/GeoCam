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
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'lib/assets/images/tutorial.png',
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '¡BIENVENIDO!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 3, 3, 3),
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Toca el ícono (?) para aprender cómo usar la app.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
                children: [
                  _buildButton(context, "Calkiní", const PantallaCK(),
                      'lib/assets/images/calkinibtn.png'),
                  _buildButton(context, "Bécal", const PantallaBC(),
                      'lib/assets/images/becalbtn.jpg'),
                  _buildButton(context, "Dzitbalché", const PantallaDZ(),
                      'lib/assets/images/dzitbalchebtn.jpeg'),
                  _buildButton(context, "Nunkiní", const PantallaNK(),
                      'lib/assets/images/nunkinibtn.jpg'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Aquí se controlan los botones
  Widget _buildButton(
    BuildContext context,
    String text,
    Widget screen,
    String imagePath,
  ) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        elevation: 6,
      ),
      child: Ink(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.40),
              BlendMode.darken,
            ),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black,
                  offset: Offset(1, 1),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
