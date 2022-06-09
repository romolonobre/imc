import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:icmc/home/home_controller.dart';
import 'package:icmc/home/widgets/imc_gauge.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final pesoEc = TextEditingController();
  final alturaEc = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                ValueListenableBuilder<double>(
                  valueListenable: controller.imc,
                  builder: (_, value, __) {
                    return ImcGauge(imc: value);
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                    controller: pesoEc,
                    keyboardType: const TextInputType.numberWithOptions(),
                    decoration: const InputDecoration(labelText: 'Peso'),
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                          locale: 'pt_BR',
                          symbol: '',
                          decimalDigits: 2,
                          turnOffGrouping: true),
                    ],
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo Obrigatorio';
                      }
                      return null;
                    }),
                TextFormField(
                    controller: alturaEc,
                    keyboardType: const TextInputType.numberWithOptions(),
                    decoration: const InputDecoration(labelText: 'Altura'),
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                          locale: 'pt_BR',
                          symbol: '',
                          decimalDigits: 2,
                          turnOffGrouping: true),
                    ],
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo Obrigatorio';
                      }
                      return null;
                    }),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    var formVa = formKey.currentState?.validate() ?? false;
                    if (formVa) {
                      var formatter = NumberFormat.simpleCurrency(
                        locale: 'pt_BR',
                        decimalDigits: 2,
                      );
                      double peso = formatter.parse(pesoEc.text) as double;
                      double altura = formatter.parse(alturaEc.text) as double;

                      controller.calcularImc(peso: peso, altura: altura);
                      controller.showSnackBar(
                          context, controller.imc.value, messageSnakbar());
                    }
                  },
                  child: const Text('calcular imc'),
                ),
                const SizedBox(height: 10),
                TextButton(
                    onPressed: () {
                      pesoEc.text = '';
                      alturaEc.text = '';
                      controller.resetImc();
                    },
                    child: const Text('Reset'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textWidget(
      String message, Color color, double fontsize, FontWeight fontWeight) {
    return Text(
      message,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontsize,
      ),
    );
  }

  Widget messageSnakbar() {
    double imc = controller.imc.value;
    if (imc <= 18) {
      return textWidget(
          'You should eat more', Colors.blue, 18, FontWeight.bold);
    } else if (imc <= 24.9) {
      return textWidget('You are fit', Colors.green, 18, FontWeight.bold);
    } else if (imc <= 29.9) {
      return textWidget(
          'You should eat less', Colors.yellow, 18, FontWeight.bold);
    } else if (imc <= 39.9) {
      return textWidget(
          'You must eat less', Colors.yellow, 18, FontWeight.bold);
    } else if (imc <= 49.9) {
      return textWidget(
          'You should see a doctor', Colors.yellow, 18, FontWeight.bold);
    }
    return textWidget('imc not found', Colors.yellow, 18, FontWeight.bold);
  }
}
