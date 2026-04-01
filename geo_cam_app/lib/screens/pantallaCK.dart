import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'exploramunicipios/exploraCK/explora.dart';
import 'guardado.dart';
import 'historia.dart';

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
      backgroundColor: const Color.fromARGB(255, 234, 228, 205),
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          // contenido scrolleable
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // HOLA con pajarito a la derecha
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'HOLA',
                        style: const TextStyle(
                          fontSize: 34,
                          fontFamily: "Kigali_Lx_Regular",
                          fontWeight: FontWeight.w100,
                          letterSpacing: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, right: 15),
                        child: Image.asset(
                          'lib/assets/images/bird.png',
                          width: 70,
                          height: 70,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 0),

                  // ✅ nombre del municipio en su propia línea
                  Text(
                    municipalityData['title'],
                    style: const TextStyle(
                      fontSize: 34,
                      fontFamily: "Kigali_Lx_Regular",
                      fontWeight: FontWeight.w100,
                      letterSpacing: 2,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // descripción centrada y contenida
                  Center(
                    child: Container(
                      width: 360,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        municipalityData['description'],
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // imagen del municipio
                  Center(
                    child: Container(
                      width: 320,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          municipalityData['image'],
                          width: 320,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // botones
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      municipalityData['options'].length,
                      (index) {
                        final opcion = municipalityData['options'][index];
                        return ElevatedButton(
                          onPressed: () {
                            Widget? pantallaDestino;
                            switch (opcion) {
                              case 'Explora':
                                pantallaDestino = const Explora();
                                break;
                              case 'Guardado':
                                pantallaDestino = const guardado();
                                break;
                              case 'Historia':
                                pantallaDestino = const historia();
                                break;
                              default:
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Opción no encontrada: $opcion'),
                                  ),
                                );
                                return;
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => pantallaDestino!,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 216, 210, 121),
                            foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                            elevation: 4,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                          child: Text(
                            opcion,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // footer con la misma imagen del header
          SizedBox(
            width: double.infinity,
            height: kToolbarHeight + MediaQuery.of(context).padding.top,
            child: Image.asset(
              municipalityData['appbarimage'],
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}