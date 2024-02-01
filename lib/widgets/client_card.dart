import 'package:flutter/material.dart';
import 'package:mower_control_app/models/client.dart';

class ClientCard extends StatelessWidget {
  const ClientCard({super.key, required this.client});

  final Client client;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                client.name,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                client.address,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              const SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${client.phoneNumber}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
            ],
          )),
    );
  }
}
