import 'package:flutter/material.dart';

class PantallaNK extends StatelessWidget {
  const PantallaNK({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text ("Pantalla para nunkiní")),
      body: const Center(
        child: Text("Esta es la Pantalla para Nunkiní"),
      ),
    );
  }
}