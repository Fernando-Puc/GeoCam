import 'package:flutter/material.dart';

class explora extends StatelessWidget {
  const explora({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text ("pantalla explora")),
      body: const Center(
        child: Text("Esta pantalla es para explorar el municipio"),
      ),
    );
  }
}