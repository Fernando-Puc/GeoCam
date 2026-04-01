import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Tiendas extends StatelessWidget {
  const Tiendas({super.key});

  final List<Map<String, dynamic>> locales = const [
    {
      'nombre': 'KMODA CALKINI',
      'lat': 20.37274794392908,
      'lng': -90.05017531923694,
    },
    {
      'nombre': 'Mi Bodega Aurrera, Calkiní',
      'lat': 20.361906286518217,
      'lng': -90.05237372289213, 
    },
    {
      'nombre': 'Milano Calkiní',
      'lat': 20.371110841202853,
      'lng': -90.0503705791943,   
    },
    {
      'nombre': 'Super Willys Centro',
      'lat': 20.372096871661835,
      'lng': -90.0501332117043,
    },
    {
      'nombre': 'Coppel La Ceiba',
      'lat': 20.369536459833263,
      'lng': -90.05315399512264,
    },
    {
      'nombre': 'Súper Willys Mercado',
      'lat': 20.368621864510853,
      'lng': -90.05557133069695,
    }, 
    {
      'nombre': 'Súper Willys Fatima',
      'lat': 20.379479895028627,
      'lng': -90.05359607022942,
    }, 
    {
      'nombre': 'OXXO CALKINI',
      'lat': 20.37899120883751,
      'lng': -90.04849111998921,
    },
    {
      'nombre': 'Super Willys',
      'lat': 20.364467785679327,
      'lng': -90.0518429957272,
    }, 
    {
      'nombre': 'Comercializadora San José',
      'lat': 20.345906653478714,
      'lng': -90.05038534235355,
    }, 
    {
      'nombre': 'La Quemazon Calkini',
      'lat': 20.37082392938681,
      'lng': -90.05039611720143,
    },
    {
      'nombre': 'Superpapelería karla calkini',
      'lat': 20.370034600827566,
      'lng': -90.05057560493317,
    },
    {
      'nombre': 'Kositerias Calkiní',
      'lat': 20.36937349425065,
      'lng': -90.05075129925127,
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
