import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class historia extends StatefulWidget {
  const historia({super.key});

  @override
  State<historia> createState() => _historiaState();
}

class _historiaState extends State<historia> {
  Map<String, dynamic>? historiaData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final String response = await rootBundle.loadString(
      'lib/data/municipality/calkini/calkini.json',
    );
    final data = json.decode(response);
    setState(() {
      historiaData = data['historia'];
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

    if (historiaData == null) {
      return const Scaffold(
        body: Center(child: Text('No hay historia disponible.')),
      );
    }

    final imagenPrincipal = historiaData!['imagen_principal'] ?? '';
    final secciones = List<dynamic>.from(historiaData!['secciones'] ?? []);

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
          onPressed: () => Navigator.pop(context),
          backgroundColor: const Color.fromARGB(255, 195, 57, 15),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // título
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 195, 57, 15),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Text(
                      historiaData!['titulo'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontFamily: "Kigali_Lx_Regular",
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // imagen principal
                  if (imagenPrincipal.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        imagenPrincipal,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 210, 200, 170),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image_outlined,
                              size: 60, color: Colors.black26),
                          SizedBox(height: 8),
                          Text(
                            'Imagen próximamente',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black38,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 20),

                  // ✅ secciones con subtítulo en negrita
                  ...secciones.map((seccion) {
                    final subtitulo = seccion['subtitulo'] ?? '';
                    final contenido = seccion['contenido'] ?? '';

                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 210, 200, 170),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ✅ subtítulo en negrita solo si no está vacío
                          if (subtitulo.isNotEmpty) ...[
                            Text(
                              subtitulo,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 195, 57, 15),
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                          // contenido
                          Text(
                            contenido,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.7,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // footer
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