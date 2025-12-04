import 'package:flutter/material.dart';

class PantallaDZ extends StatelessWidget {
  const PantallaDZ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text ("Pantalla para dzitbalché")),
      body: const Center(
        child: Text("Esta es la Pantalla para Dzitbalché"),
      ),
    );
  }
}