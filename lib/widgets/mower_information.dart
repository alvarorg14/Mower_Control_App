import 'package:flutter/material.dart';
import 'package:mower_control_app/models/mower.dart';

class MowerInforamtion extends StatelessWidget {
  const MowerInforamtion({super.key, required this.mower});

  final Mower mower;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                mower.name,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Model: ${mower.model.name}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Serial number: ${mower.serialNumber}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ],
          )),
    );
  }
}
