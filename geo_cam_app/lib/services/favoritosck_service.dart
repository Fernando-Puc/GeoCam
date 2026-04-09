import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritosCKService {
  static const String _key = 'favoritos';

  // ✅ obtener todos los favoritos
  static Future<List<Map<String, dynamic>>> getFavoritos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_key);
    if (data == null) return [];
    final List<dynamic> lista = json.decode(data);
    return lista.cast<Map<String, dynamic>>();
  }

  // ✅ agregar favorito
  static Future<void> agregar(Map<String, dynamic> lugar) async {
    final prefs = await SharedPreferences.getInstance();
    final favoritos = await getFavoritos();
    // evitar duplicados por nombre y tipo
    final existe = favoritos.any(
      (f) => f['nombre'] == lugar['nombre'] && f['tipo'] == lugar['tipo'],
    );
    if (!existe) {
      favoritos.add(lugar);
      await prefs.setString(_key, json.encode(favoritos));
    }
  }

  // ✅ eliminar favorito
  static Future<void> eliminar(String nombre, String tipo) async {
    final prefs = await SharedPreferences.getInstance();
    final favoritos = await getFavoritos();
    favoritos.removeWhere(
      (f) => f['nombre'] == nombre && f['tipo'] == tipo,
    );
    await prefs.setString(_key, json.encode(favoritos));
  }

  // ✅ verificar si ya está guardado
  static Future<bool> esFavorito(String nombre, String tipo) async {
    final favoritos = await getFavoritos();
    return favoritos.any(
      (f) => f['nombre'] == nombre && f['tipo'] == tipo,
    );
  }
}