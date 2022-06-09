import 'dart:math';

import 'package:flutter/material.dart';

class HomeController {
  ValueNotifier<double> imc = ValueNotifier(0);

  void calcularImc({required double peso, required double altura}) {
    imc.value = peso / pow(altura, 2);
  }

  void resetImc() {
    imc.value = 0;
  }

  void showSnackBar(BuildContext context, double imcd, Widget widget) {
    final showSnak = SnackBar(
      backgroundColor: Colors.black87,
      content: widget,
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(showSnak);
  }
}
