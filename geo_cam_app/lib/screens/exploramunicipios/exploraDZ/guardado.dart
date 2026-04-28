import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart' as ll;
import 'package:flutter_map/flutter_map.dart';
import 'package:geo_cam_app/services/favoritosdz_service.dart';

class guardado extends StatefulWidget {
  const guardado({super.key});

  @override
  State<guardado> createState() => _guardadoState();
}

class _guardadoState extends State<guardado> {
  List<Map<String, dynamic>> favoritos = [];
  bool isLoading = true;
  int? _expandedIndex;

  @override
  void initState() {
    super.initState();
    _loadFavoritos();
  }

  Future<void> _loadFavoritos() async {
    final data = await FavoritosDZService.getFavoritos();
    setState(() {
      favoritos = data;
      isLoading = false;
    });
  }

  Future<void> _eliminarFavorito(String nombre, String tipo) async {
    await FavoritosDZService.eliminar(nombre, tipo);
    setState(() {
      favoritos.removeWhere(
        (f) => f['nombre'] == nombre && f['tipo'] == tipo,
      );
      _expandedIndex = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$nombre eliminado de favoritos'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _abrirMapa(double lat, double lng) async {
    final Uri url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'No se pudo abrir Google Maps';
    }
  }

  // ícono según tipo de lugar
  IconData _iconoPorTipo(String tipo) {
    switch (tipo) {
      case 'Hotel':
        return Icons.hotel;
      case 'Restaurante':
        return Icons.restaurant;
      case 'Tienda':
        return Icons.store;
      case 'Local Artesanal':
        return Icons.palette;
      case 'Balneario':
        return Icons.pool;
      case 'Zona Arqueológica':
        return Icons.account_balance;
      case 'Centro Religioso':
        return Icons.church;
      case 'Cafetería':
        return Icons.coffee;
      case 'Transporte':
        return Icons.directions_bus;
      default:
        return Icons.place;
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
              'LUGARES GUARDADOS',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                fontFamily: "Kigali_Lx_Regular",
              ),
            ),
          ),

          Expanded(
            child: favoritos.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite_border,
                            size: 60, color: Colors.black26),
                        SizedBox(height: 12),
                        Text(
                          'No tienes lugares guardados aún.\nExplora y guarda tus favoritos.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    itemCount: favoritos.length,
                    itemBuilder: (context, index) {
                      final lugar = favoritos[index];
                      final isExpanded = _expandedIndex == index;
                      final double? lat = lugar['lat']?.toDouble();
                      final double? lng = lugar['lng']?.toDouble();
                      final imagenes =
                          List<String>.from(lugar['imagenes'] ?? []);
                      final horario =
                          List<dynamic>.from(lugar['horario'] ?? []);

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

                            // fila simple con corazón rojo para eliminar
                            InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                setState(() {
                                  _expandedIndex =
                                      isExpanded ? null : index;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                child: Row(
                                  children: [
                                    Icon(
                                      _iconoPorTipo(lugar['tipo'] ?? ''),
                                      color: const Color.fromARGB(
                                          255, 195, 57, 15),
                                      size: 20,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            lugar['nombre'] ?? '',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            '${lugar['tipo'] ?? ''} • ${lugar['direccion'] ?? ''}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // corazón para eliminar
                                    GestureDetector(
                                      onTap: () => _eliminarFavorito(
                                          lugar['nombre'], lugar['tipo']),
                                      child: const Icon(
                                        Icons.favorite,
                                        color: Color.fromARGB(
                                            255, 195, 57, 15),
                                        size: 22,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(
                                      isExpanded
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      color: const Color.fromARGB(
                                          255, 195, 57, 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // detalle expandido
                            if (isExpanded) ...[
                              const Divider(height: 1),

                              Padding(
                                padding: const EdgeInsets.all(14),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [

                                    // descripción
                                    if (lugar['descripcion'] != null &&
                                        lugar['descripcion']
                                            .toString()
                                            .isNotEmpty)
                                      Text(
                                        lugar['descripcion'],
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                            fontSize: 13, height: 1.5),
                                      ),

                                    const SizedBox(height: 12),

                                    // horario y dirección
                                    if (horario.isNotEmpty)
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(10),
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
                                                      Icon(
                                                          Icons.access_time,
                                                          size: 14,
                                                          color: Color.fromARGB(
                                                              255, 195, 57,
                                                              15)),
                                                      SizedBox(width: 4),
                                                      Text('Horario',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                            fontSize: 13,
                                                          )),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 6),
                                                  ...horario.map((h) =>
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 2),
                                                        child: Text(
                                                          '${h['dia']}: ${h['hora']}',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      11),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(10),
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
                                                              255, 195, 57,
                                                              15)),
                                                      SizedBox(width: 4),
                                                      Text('Dirección',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                            fontSize: 13,
                                                          )),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    lugar['direccion'] ?? '',
                                                    style: const TextStyle(
                                                        fontSize: 11),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                    const SizedBox(height: 12),

                                    // mapa
                                    if (lat != null && lng != null) ...[
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        child: SizedBox(
                                          height: 180,
                                          child: FlutterMap(
                                            options: MapOptions(
                                              initialCenter:
                                                  ll.LatLng(lat, lng),
                                              initialZoom: 15,
                                              interactionOptions:
                                                  const InteractionOptions(
                                                flags:
                                                    InteractiveFlag.none,
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
                                                    point: ll.LatLng(
                                                        lat, lng),
                                                    width: 40,
                                                    height: 40,
                                                    child: GestureDetector(
                                                      onTap: () =>
                                                          _abrirMapa(
                                                              lat, lng),
                                                      child: const Icon(
                                                        Icons.location_pin,
                                                        color: Color.fromARGB(
                                                            255, 195, 57,
                                                            15),
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
                                    ],

                                    // imágenes
                                    if (imagenes.isNotEmpty) ...[
                                      const SizedBox(height: 12),
                                      const Divider(height: 1),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'Imágenes',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Color.fromARGB(
                                              255, 195, 57, 15),
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
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            child: Image.asset(
                                              imagenes[i],
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        },
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