import 'package:flutter/material.dart';
import 'package:mower_control_app/models/mower.dart';
import 'package:mower_control_app/widgets/mower_status.dart';

class MowerCard extends StatelessWidget {
  const MowerCard({super.key, required this.mower});

  final Mower mower;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 10,
            child: 
          ),
        ],
      ),
    );
  }
}
