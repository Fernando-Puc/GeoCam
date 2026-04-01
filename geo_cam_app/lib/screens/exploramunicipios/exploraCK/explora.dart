import 'package:flutter/material.dart';
import 'package:geo_cam_app/screens/exploramunicipios/exploraCK/hoteles.dart';
import 'package:geo_cam_app/screens/exploramunicipios/exploraCK/restaurantes.dart';
import 'package:geo_cam_app/screens/exploramunicipios/exploraCK/tiendas.dart';
import 'package:geo_cam_app/screens/exploramunicipios/exploraCK/localesartesanales.dart';
import 'package:geo_cam_app/screens/exploramunicipios/exploraCK/diasfestivos.dart';

class Explora extends StatelessWidget {
  const Explora({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 228, 205),
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          backgroundColor: const Color.fromARGB(255, 195, 57, 15),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
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
              child: Column(
                children: [
                  // ✅ grid sin Expanded, se ajusta a su contenido
                  GridView.count(
                    shrinkWrap: true, // ✅ ocupa solo lo necesario
                    physics: const NeverScrollableScrollPhysics(), // ✅ scroll lo maneja el padre
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.6,
                    children: [
                      _buildButton(context, "Locales Artesanales", const LocalesArtesanales(),
                          'lib/assets/images/artesania.jpg'),
                      _buildButton(context, "Tiendas o Negocios", const Tiendas(),
                          'lib/assets/images/tiendas.jpg'),
                      _buildButton(context, "Restaurantes", const Restaurantes(),
                          'lib/assets/images/restaurante.jpg'),
                      _buildButton(context, "Hoteles", const Hoteles(),
                          'lib/assets/images/hotel.jpeg'),
                      _buildButton(context, "Balnearios", const Restaurantes(),
                          'lib/assets/images/piscina.png'),
                      _buildButton(context, "Zona Arqueológicas", const Restaurantes(),
                          'lib/assets/images/zonaarq.jpg'),
                      _buildButton(context, "Centros Religiosos", const Restaurantes(),
                          'lib/assets/images/religion.jpg'),
                      _buildButton(context, "Cafeterías", const Restaurantes(),
                          'lib/assets/images/cafeteria.jpg'),
                      _buildButton(context, "Transporte", const Restaurantes(),
                          'lib/assets/images/transporte.png'),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ✅ Días Festivos justo debajo del grid
                  _buildWideButton(
                    context,
                    'Días Festivos',
                    const DiasFestivos(),
                    'lib/assets/images/diaFestivoCK.jpg',
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // ✅ footer
          SizedBox(
            width: double.infinity,
            height: kToolbarHeight + MediaQuery.of(context).padding.top,
            child: Image.asset(
              'lib/assets/images/DiseñoHF.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class ExploraBC extends StatelessWidget {
  const ExploraBC({super.key});

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

// botón normal para el grid
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

// botón ancho para Días Festivos
Widget _buildWideButton(
  BuildContext context,
  String text,
  Widget screen,
  String imagePath,
) {
  return SizedBox(
    width: double.infinity,
    height: 80,
    child: ElevatedButton(
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
              fontSize: 22,
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
    ),
  );
}