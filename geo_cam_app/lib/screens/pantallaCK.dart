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
    final String response = await rootBundle.loadString(
      'lib/data/municipality/calkini/calkini.json',
    );

    final data = json.decode(response);

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
        centerTitle: true,
        flexibleSpace: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              municipalityData['appbarimage'], 
              fit: BoxFit.cover,
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // texto del municipio
            Text(
              municipalityData['title'],
              style: const TextStyle(
                  fontSize: 40,
                  fontFamily: "Kigali_Lx_Regular", // usa el family del pubspec
                  fontWeight: FontWeight.w100,
                  letterSpacing: 2),
            ),

            const SizedBox(height: 20),

            // descripcion del municipio
            Text(
              municipalityData['description'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            // imagen del municipio
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

            // botones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                municipalityData['options'].length,
                (index) => ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${municipalityData['options'][index]} seleccionado',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color.fromARGB(255, 196, 14, 14),
                    shadowColor: Colors.black45,
                    elevation: 4,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 196, 14, 14),
                        width: 2,
                      ),
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
            ),
          ],
        ),
      ),
    );
  }
}