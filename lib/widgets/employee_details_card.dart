import 'package:flutter/material.dart';

class EmployeeDetails extends StatelessWidget {
  const EmployeeDetails({
    super.key,
    required this.name,
    required this.surname1,
    required this.surname2,
    required this.username,
  });

  final String name;
  final String surname1;
  final String? surname2;
  final String username;

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
              'Empleado',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Nombre y apellidos: $name $surname1 ${surname2 ?? ''}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Usuario: $username',
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
