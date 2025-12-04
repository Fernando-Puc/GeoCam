import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class PantallaCK extends StatefulWidget {
  const PantallaCK({super.key});

  @override
  State<PantallaCK> createState() => _PantallaCKState();
}

class _PantallaCKState extends State<PantallaCK> {
  late Map<String, dynamic> municipalityData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMunicipalityData();
  }

  Future<void> _loadMunicipalityData() async {
    // imagen 
    final String response = await rootBundle.loadString(
      'lib/data/municipality/calkini/calkini.json',
    );
    final data = await json.decode(response);

    setState(() {
      municipalityData = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(municipalityData['name']),
        backgroundColor: const Color.fromARGB(255, 196, 14, 14),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del municipio
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                municipalityData['image'],
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // DescripciÃ³n
            Text(
              municipalityData['description'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),

            // Botones de opciones mejorados
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: List.generate(
    municipalityData['options'].length,
    (index) => ElevatedButton(
      onPressed: () {
        // si se presiona
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${municipalityData['options'][index]} seleccionado'),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, 
        foregroundColor: const Color.fromARGB(255, 196, 14, 14), 
        shadowColor: Colors.black45, 
        elevation: 4, 
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: const BorderSide(color: Color.fromARGB(255, 196, 14, 14), width: 2), 
        ),
      ),
      child: Text(
        municipalityData['options'][index],
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  ),
)
          ],
        ),
      ),
    );
  }
}