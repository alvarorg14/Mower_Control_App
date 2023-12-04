import 'package:flutter/material.dart';
import 'package:mower_control_app/models/mower.dart';

class MowerStatus extends StatelessWidget {
  const MowerStatus({super.key, required this.mower});

  final Mower mower;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.yellow,
              width: 3.0,
            ),
          ),
          child: ClipOval(
            child: Image.asset('assets/images/405X.png'),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          mower.activity,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ],
    );
  }
}
