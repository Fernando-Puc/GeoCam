import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as ll;
import 'package:geo_cam_app/services/favoritosnk_service.dart';

class Cafeterias extends StatefulWidget {
  const Cafeterias({super.key});

  @override
  State<Cafeterias> createState() => _CafeteriasState();
}

class _CafeteriasState extends State<Cafeterias> {
  List<dynamic> cafeterias = [];
  bool isLoading = true;
  int? _expandedIndex;
  Map<int, bool> _favoritos = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final String response = await rootBundle.loadString(
      'lib/data/municipality/nunkini/cafeterias.json',
    );
    final data = json.decode(response);

    setState(() {
      cafeterias = data['cafeterias'];
      isLoading = false;
    });

    await _checkFavoritos();
  }

  Future<void> _checkFavoritos() async {
    for (int i = 0; i < cafeterias.length; i++) {
      final esFav = await FavoritosNKService.esFavorito(
          cafeterias[i]['nombre'], 'Cafeteria');

      setState(() {
        _favoritos[i] = esFav;
      });
    }
  }

  Future<void> _toggleFavorito(int index, Map<String, dynamic> item) async {
    final esFav = _favoritos[index] ?? false;

    if (esFav) {
      await FavoritosNKService.eliminar(item['nombre'], 'Cafeteria');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${item['nombre']} eliminado de favoritos'),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      await FavoritosNKService.agregar({
        ...item,
        'tipo': 'Cafeteria',
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${item['nombre']} guardado en favoritos'),
          duration: const Duration(seconds: 2),
        ),
      );
    }

    setState(() {
      _favoritos[index] = !esFav;
    });
  }

  Future<void> _abrirMapa(double lat, double lng) async {
    final Uri url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'No se pudo abrir Google Maps';
    }
  }

  Future<void> _llamar(String telefono) async {
    final Uri url = Uri.parse('tel:$telefono');
    if (!await launchUrl(url)) {
      throw 'No se pudo realizar la llamada';
    }
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
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              itemCount: cafeterias.length,
              itemBuilder: (context, index) {
                final item = cafeterias[index];
                final imagenPrincipal = item['imagen_principal'] ?? '';
                final imagenes = List<String>.from(item['imagenes'] ?? []);
                final horario = List<dynamic>.from(item['horario'] ?? []);
                final double lat = item['lat'];
                final double lng = item['lng'];
                final isExpanded = _expandedIndex == index;
                final esFavorito = _favoritos[index] ?? false;

                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 210, 200, 170),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [

                      // HEADER
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          setState(() {
                            _expandedIndex = isExpanded ? null : index;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.local_cafe,
                                color: Color.fromARGB(255, 195, 57, 15),
                                size: 20,
                              ),
                              const SizedBox(width: 10),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['nombre'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Dirección: ${item['direccion'] ?? ''}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              GestureDetector(
                                onTap: () =>
                                    _toggleFavorito(index, Map<String, dynamic>.from(item)),
                                child: Icon(
                                  esFavorito
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: const Color.fromARGB(255, 195, 57, 15),
                                  size: 22,
                                ),
                              ),

                              const SizedBox(width: 8),

                              Icon(
                                isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: const Color.fromARGB(255, 195, 57, 15),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // EXPANDIDO
                      if (isExpanded) ...[
                        const Divider(height: 1),

                        if (imagenPrincipal.isNotEmpty)
                          ClipRRect(
                            child: Image.asset(
                              imagenPrincipal,
                              width: double.infinity,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                          )
                        else
                          Container(
                            width: double.infinity,
                            height: 160,
                            color: const Color.fromARGB(255, 210, 200, 170),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.local_cafe,
                                    size: 50, color: Colors.black26),
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

                        Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              if (item['descripcion'] != null &&
                                  item['descripcion'].toString().isNotEmpty)
                                Text(
                                  item['descripcion'],
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                      fontSize: 13, height: 1.5),
                                ),

                              const SizedBox(height: 12),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 234, 228, 205),
                                        borderRadius:
                                            BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Row(
                                            children: [
                                              Icon(Icons.access_time,
                                                  size: 14,
                                                  color: Color.fromARGB(
                                                      255, 195, 57, 15)),
                                              SizedBox(width: 4),
                                              Text('Horario',
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: 13,
                                                  )),
                                            ],
                                          ),
                                          const SizedBox(height: 6),
                                          ...horario.map((h) => Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        bottom: 2),
                                                child: Text(
                                                  '${h['dia']}: ${h['hora']}',
                                                  style: const TextStyle(
                                                      fontSize: 11),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 10),

                                  Expanded(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 234, 228, 205),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Row(
                                                children: [
                                                  Icon(Icons.location_on,
                                                      size: 14,
                                                      color: Color.fromARGB(
                                                          255, 195, 57, 15)),
                                                  SizedBox(width: 4),
                                                  Text('Dirección',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13,
                                                      )),
                                                ],
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                item['direccion'] ?? '',
                                                style: const TextStyle(
                                                    fontSize: 11),
                                              ),
                                            ],
                                          ),
                                        ),

                                        const SizedBox(height: 8),

                                        if (item['telefono'] != null)
                                          GestureDetector(
                                            onTap: () =>
                                                _llamar(item['telefono']),
                                            child: Container(
                                              width: double.infinity,
                                              padding:
                                                  const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 234, 228, 205),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.phone,
                                                      size: 14,
                                                      color: Color.fromARGB(
                                                          255, 195, 57, 15)),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    item['telefono'],
                                                    style: const TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 180,
                                  child: FlutterMap(
                                    options: MapOptions(
                                      initialCenter: ll.LatLng(lat, lng),
                                      initialZoom: 15,
                                      interactionOptions:
                                          const InteractionOptions(
                                        flags: InteractiveFlag.none,
                                      ),
                                    ),
                                    children: [
                                      TileLayer(
                                        urlTemplate:
                                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                        userAgentPackageName:
                                            'com.example.geo_cam_app',
                                      ),
                                      MarkerLayer(
                                        markers: [
                                          Marker(
                                            point: ll.LatLng(lat, lng),
                                            child: GestureDetector(
                                              onTap: () =>
                                                  _abrirMapa(lat, lng),
                                              child: const Icon(
                                                Icons.location_pin,
                                                color: Color.fromARGB(
                                                    255, 195, 57, 15),
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 8),

                              if (imagenes.isNotEmpty) ...[
                                const Divider(height: 1),
                                const SizedBox(height: 10),
                                const Text(
                                  'Imágenes',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Color.fromARGB(255, 195, 57, 15),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics:
                                      const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 6,
                                    mainAxisSpacing: 6,
                                  ),
                                  itemCount: imagenes.length,
                                  itemBuilder: (context, i) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.asset(
                                        imagenes[i],
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                ),
                              ] else ...[
                                const Divider(height: 1),
                                const SizedBox(height: 10),
                                const Center(
                                  child: Text(
                                    'Imágenes próximamente disponibles',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black38,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],

                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ],
                    ],
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