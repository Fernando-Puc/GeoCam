import 'package:flutter/material.dart';
import 'pantallaCK.dart';
import 'pantallaBC.dart';
import 'pantallaDZ.dart';
import 'pantallaNK.dart';

class explora extends StatelessWidget {
  const explora({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color.fromARGB(255, 234, 228, 205),
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'lib/assets/images/DiseñoHF.png',
              fit: BoxFit.cover,
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: const Color.fromARGB(255, 195, 57, 15),
        child: const Icon(Icons.arrow_back, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Column(
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 230, 212, 13),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/images/lupa.png',
                    width: 60,
                    height: 60,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CALKINÍ',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 3, 3, 3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 7,
                childAspectRatio: 1.6,
                children: [
                  _buildButton(context, "Locales Artesanales",const PantallaCK(),
                    'lib/assets/images/artesania.jpg'),
                  _buildButton(context, "Tiendas o Negocios", const PantallaBC(), 
                    'lib/assets/images/tiendas.jpg'),
                  _buildButton(context, "Restaurantes", const PantallaDZ(),
                    'lib/assets/images/restaurante.jpg'),
                  _buildButton(context, "Hoteles", const PantallaNK(),
                    'lib/assets/images/hotel.jpeg'),
                  _buildButton(context, "Balnearios", const PantallaNK(),
                    'lib/assets/images/piscina.png'),
                  _buildButton(context, "Zona Arqueológicas", const PantallaNK(), 
                    'lib/assets/images/zonaarq.jpg'),
                  _buildButton(context, "Centros Religiosos", const PantallaNK(), 
                    'lib/assets/images/religion.jpg'),
                  _buildButton(context, "Cafeterías", const PantallaNK(),
                    'lib/assets/images/cafeteria.jpg'),
                  _buildButton(context, "Transporte", const PantallaNK(),
                    'lib/assets/images/transporte.png'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class exploraBC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("pantalla explora para bécal")),
      body: const Center(
        child: Text("Esta pantalla es para explorar el municipio de becal"),
      ),
    );
  }
}

//control de botones
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
        borderRadius: BorderRadius.circular(1),
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
        borderRadius: BorderRadius.circular(1),
      ),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
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
