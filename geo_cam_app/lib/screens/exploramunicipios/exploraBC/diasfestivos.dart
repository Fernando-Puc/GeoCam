import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DiasFestivos extends StatefulWidget {
  const DiasFestivos({super.key});

  @override
  State<DiasFestivos> createState() => _DiasFestivosState();
}

class _DiasFestivosState extends State<DiasFestivos> {
  List<dynamic> meses = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final String response = await rootBundle.loadString(
      'lib/data/municipality/becal/diasFestivos.json',
    );
    final data = json.decode(response);
    setState(() {
      meses = data['meses'];
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
            Image.asset('lib/assets/images/DiseñoHF.png', fit: BoxFit.cover),
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
          // título
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Text(
              'FECHAS DE FIESTAS Y\nTRADICIONES',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),

          // grid de meses
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: GridView.builder(
                itemCount: meses.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.8,
                ),
                itemBuilder: (context, index) {
                  final mes = meses[index];
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FechasMes(
                            nombreMes: mes['nombre'],
                            festividades: List<dynamic>.from(
                                mes['festividades'] ?? []),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 210, 190, 150),
                      foregroundColor: Colors.black,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text(
                      mes['nombre'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
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

class FechasMes extends StatefulWidget {
  final String nombreMes;
  final List<dynamic> festividades;

  const FechasMes({
    super.key,
    required this.nombreMes,
    required this.festividades,
  });

  @override
  State<FechasMes> createState() => _FechasMesState();
}

class _FechasMesState extends State<FechasMes> {
  int? _expandedIndex;

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
            Image.asset('lib/assets/images/DiseñoHF.png', fit: BoxFit.cover),
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
          // título del mes
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Text(
              widget.nombreMes,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: "Kigali_Lx_Regular",
                letterSpacing: 2,
              ),
            ),
          ),

          Expanded(
            child: widget.festividades.isEmpty
                ? const Center(
                    child: Text(
                      'No hay festividades registradas\npara este mes.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    itemCount: widget.festividades.length,
                    itemBuilder: (context, index) {
                      final fest = widget.festividades[index];
                      final eventos =
                          List<dynamic>.from(fest['eventos'] ?? []);
                      final imagenes =
                          List<String>.from(fest['imagenes'] ?? []);
                      final fechaCelebracion =
                          fest['fecha_celebracion'] ?? '';
                      final imagenPrincipal =
                          fest['imagen_principal'] ?? '';
                      final isExpanded = _expandedIndex == index;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 234, 228, 205),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            // ✅ header rojo con título
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(14),
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 195, 57, 15),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                              ),
                              child: Text(
                                fest['titulo'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),

                            const SizedBox(height: 4), // espacio título-imagen

                            // ✅ imagen centrada con bordes redondeados
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14),
                              child: imagenPrincipal.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        imagenPrincipal,
                                        width: double.infinity,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Container(
                                      width: double.infinity,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 210, 200, 170),
                                        borderRadius:
                                            BorderRadius.circular(12),
                                      ),
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.image_outlined,
                                            size: 50,
                                            color: Colors.black26,
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            'Imagen próximamente',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black38,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),

                            const SizedBox(height: 4), // espacio imagen-descripción

                            // descripción
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: Text(
                                fest['descripcion'],
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                    fontSize: 13, height: 1.5),
                              ),
                            ),

                            // fecha de celebración
                            if (fechaCelebracion.isNotEmpty)
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 4),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                      255, 210, 200, 170),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_today,
                                      size: 14,
                                      color: Color.fromARGB(255, 195, 57, 15),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Fecha de celebración: $fechaCelebracion',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            const SizedBox(height: 10),
                            const Divider(height: 1),

                            // botones acordeón e imágenes
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _expandedIndex =
                                            isExpanded ? null : index;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          isExpanded
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down,
                                          color: const Color.fromARGB(
                                              255, 195, 57, 15),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          isExpanded
                                              ? 'Ocultar fechas'
                                              : 'Ver fechas',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 195, 57, 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (imagenes.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Imágenes próximamente disponibles'),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                _ImagenesGaleria(
                                              titulo: fest['titulo'],
                                              imagenes: imagenes,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.photo_library,
                                          color: Color.fromARGB(
                                              255, 195, 57, 15),
                                          size: 18,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          'Imágenes relacionadas',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline,
                                            color: Color.fromARGB(
                                                255, 195, 57, 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // acordeón de fechas
                            if (isExpanded && eventos.isNotEmpty) ...[
                              const Divider(height: 1),
                              Container(
                                color: const Color.fromARGB(255, 216, 210, 121),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                child: const Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text('Día',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      flex: 3,
                                      child: Text('Evento',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      flex: 2,
                                      child: Text('Hora',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      flex: 3,
                                      child: Text('Lugar',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                    ),
                                  ],
                                ),
                              ),
                              ...eventos.asMap().entries.map((entry) {
                                final i = entry.key;
                                final ev = entry.value;
                                return Container(
                                  color: i.isEven
                                      ? Colors.white.withOpacity(0.4)
                                      : Colors.transparent,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(ev['dia'] ?? '',
                                            style: const TextStyle(
                                                fontSize: 11, height: 1.6)),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        flex: 3,
                                        child: Text(ev['evento'] ?? '',
                                            style: const TextStyle(
                                                fontSize: 11, height: 1.6)),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        flex: 2,
                                        child: Text(ev['hora'] ?? '',
                                            style: const TextStyle(
                                                fontSize: 11, height: 1.6)),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        flex: 3,
                                        child: Text(ev['lugar'] ?? '',
                                            style: const TextStyle(
                                                fontSize: 11, height: 1.6)),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              const SizedBox(height: 8),
                            ],
                          ],
                        ),
                      );
                    },
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

// galería de imágenes relacionadas
class _ImagenesGaleria extends StatelessWidget {
  final String titulo;
  final List<String> imagenes;

  const _ImagenesGaleria({
    required this.titulo,
    required this.imagenes,
  });

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
            Image.asset('lib/assets/images/DiseñoHF.png', fit: BoxFit.cover),
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Text(
              titulo,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: imagenes.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imagenes[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
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