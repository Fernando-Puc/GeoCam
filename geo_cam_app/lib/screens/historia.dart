import 'package:flutter/material.dart';

class historia extends StatelessWidget {
  const historia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text ("pantalla de historia")),
      body: const Center(
        child: Text("Esta pantalla es de la historia del municipio"),
      ),
    );
  }
}