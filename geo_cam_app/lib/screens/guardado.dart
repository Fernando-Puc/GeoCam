import 'package:flutter/material.dart';

class guardado extends StatelessWidget {
  const guardado({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text ("pantalla de guardado")),
      body: const Center(
        child: Text("Esta pantalla es para guardar ubicaciones"),
      ),
    );
  }
}