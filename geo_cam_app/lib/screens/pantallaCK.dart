import 'package:flutter/material.dart';

class PantallaCK extends StatelessWidget {
  const PantallaCK({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pantalla Calkiní")),
      body: const Center(
        child: Text("Esta es la Pantalla para calkiní"),
      ),
    );
  }
}