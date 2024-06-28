import 'package:flutter/material.dart';

class Battery extends StatelessWidget {
  const Battery({super.key, required this.battery});

  final int battery;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '${battery} %',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        const SizedBox(
          width: 8,
        ),
        Icon(
          Icons.battery_full,
          color: Theme.of(context).colorScheme.onBackground,
          size: 20,
        ),
      ],
    );
  }
}
