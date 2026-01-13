import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Restaurantes extends StatelessWidget {
  const Restaurantes({super.key});

  final List<Map<String, dynamic>> locales = const [
    {
      'nombre': 'La Palapa, Calkini',
      'lat': 20.367405019975166,
      'lng': -90.03980597370048,
    },
    {
      'nombre': 'Restaurante El Nuevo Oasis',
      'lat': 20.371484359113918,
      'lng': -90.05027794436663,   
    },
    {
      'nombre': 'SuperPizza',
      'lat': 20.36835432765396,
      'lng': -90.05020357806661,   
    },
    {
      'nombre': 'Bon Appetit',
      'lat': 20.369762911762745,
      'lng': -90.05111001061954,
    },
    {
      'nombre': 'Restaurante "Isla Arena"',
      'lat': 20.378136823607168,
      'lng': -90.05636860894103,
    },
    {
      'nombre': 'San Bartolo y Filumena',
      'lat': 20.364634458736575,
      'lng': -90.05490327673454,
    },
    {
      'nombre': 'Lonchería "La Peña"',
      'lat': 20.369710846957048,
      'lng': -90.0509122507268,
    },
    {
      'nombre': 'El Molino Pizza',
      'lat': 20.373260910490707,
      'lng': -90.05192506215946,
    },
  ];

  Future<void> abrirMapa(double lat, double lng) async {
    final Uri url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'No se pudo abrir Google Maps';
    }
  }

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
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 90),
        itemCount: locales.length,
        itemBuilder: (context, index) {
          final local = locales[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                local['nombre'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text('Ver ubicación en Google Maps'),
              trailing: const Icon(
                Icons.location_on,
                color: Colors.red,
              ),
              onTap: () {
                abrirMapa(local['lat'], local['lng']);
              },
            ),
          );
        },
      ),
    );
  }
}
