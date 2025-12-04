import 'package:flutter/material.dart';

class PantallaBC extends StatelessWidget {
  const PantallaBC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text ("Pantalla para bécal")),
      body: const Center(
        child: Text("Esta es la Pantalla para bécal"),
      ),
    );
  }
}