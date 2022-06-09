import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'imc_gauge_range.dart';

class ImcGauge extends StatelessWidget {
  const ImcGauge({Key? key, required this.imc}) : super(key: key);

  final double imc;

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: [
        RadialAxis(
          showLabels: false,
          showAxisLine: false,
          showTicks: false,
          minimum: 12.5,
          maximum: 48,
          ranges: [
            ImcGaugeRange(
              color: Colors.blue,
              start: 12.5,
              end: 18.5,
              label: 'THIN',
            ),
            ImcGaugeRange(
              color: Colors.green,
              start: 18.5,
              end: 24.5,
              label: 'NORMAL',
            ),
            ImcGaugeRange(
                color: Colors.yellow,
                start: 24.5,
                end: 29.9,
                label: 'OVERWEIGHT'),
            ImcGaugeRange(
                color: Colors.red.shade500,
                start: 29.9,
                end: 39.9,
                label: 'OBESE'),
            ImcGaugeRange(
                color: Colors.red.shade900,
                start: 39.9,
                end: 47.9,
                label: 'SEVERE OBESITY'),
          ],
          pointers: [
            NeedlePointer(
              value: imc,
              enableAnimation: true,
            ),
          ],
        )
      ],
    );
  }
}
