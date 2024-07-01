import 'package:flutter/material.dart';
import 'package:mower_control_app/models/mower.dart';
import 'package:mower_control_app/screens/assign_mower.dart';

class UnassignedMowerCard extends StatelessWidget {
  const UnassignedMowerCard({super.key, required this.mower});

  final Mower mower;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => Navigator.of(context)
          .push(
            MaterialPageRoute(builder: (ctx) => AssignMowerScreen(mower: mower)),
          )
          .then((value) => Navigator.of(context).pop()),
      child: Card(
        elevation: 5,
        child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  'Modelo: ${mower.model.name}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Número de serie: ${mower.serialNumber}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ],
            )),
      ),
    );
  }
}
