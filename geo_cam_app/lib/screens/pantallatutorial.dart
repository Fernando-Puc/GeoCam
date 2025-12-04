import 'package:flutter/material.dart';

void pantallatutorial(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Cómo usar la aplicación"),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("1️⃣ Selecciona un municipio dando clic en uno de los botones."),
            SizedBox(height: 8),
            Text("2️⃣ Dentro del municipio podrás ver información detallada."),
            SizedBox(height: 8),
            Text("3️⃣ Explora libremente para conocer todos los municipios."),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Entendido"),
          )
        ],
      );
    },
  );
}
