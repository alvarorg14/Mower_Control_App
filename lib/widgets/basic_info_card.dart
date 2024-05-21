import 'package:flutter/material.dart';

class BasicInformation extends StatelessWidget {
  const BasicInformation({
    super.key,
    required this.mowerName,
    required this.serialNumber,
    required this.modelName,
  });

  final String mowerName;
  final int serialNumber;
  final String modelName;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Datos básicos',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Nombre: $mowerName',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Número de serie: $serialNumber',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Modelo: $modelName',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
