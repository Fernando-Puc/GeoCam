import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LocalesArtesanales extends StatelessWidget {
  const LocalesArtesanales({super.key});

  final List<Map<String, dynamic>> locales = const [
    {
      'nombre': 'Chiich Efy',
      'lat': 20.368294,
      'lng': -90.055529,
    },
    {
      'nombre': 'YC Naturals',
      'lat': 20.375239913028928,
      'lng': -90.0538419720304,   
    },
    {
      'nombre': 'Guayaberas y Filipinas Fidelia',
      'lat': 20.36996498494213,
      'lng': -90.05638964984097,   
    },
    {
      'nombre': 'Papeleria "Nicte-Ha"',
      'lat': 20.374663976771988,
      'lng': -90.05130815308308,
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
