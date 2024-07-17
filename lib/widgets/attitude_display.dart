import 'package:flutter/material.dart';

class AttitudeDisplay extends StatelessWidget {
  final double roll;
  final double pitch;
  final double yaw;

  AttitudeDisplay({required this.roll, required this.pitch, required this.yaw});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Roll: ${roll.toStringAsFixed(2)}'),
        Text('Pitch: ${pitch.toStringAsFixed(2)}'),
        Text('Yaw: ${yaw.toStringAsFixed(2)}'),
      ],
    );
  }
}
