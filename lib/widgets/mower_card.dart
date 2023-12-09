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
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Stack(
          children: [
            MowerStatus(
              mower: mower,
            ),
            Positioned(
              left: 200,
              child: Text('${mower.name}'),
            ),
          ],
        ),
      ),
    );
  }
}
