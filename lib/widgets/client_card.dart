import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mower_control_app/api/clients.dart';
import 'package:mower_control_app/api/mowers.dart';
import 'package:mower_control_app/models/client.dart';
import 'package:mower_control_app/models/mower.dart';
import 'package:mower_control_app/providers/auth_provider.dart';

class ClientCard extends ConsumerWidget {
  const ClientCard({
    super.key,
    required this.client,
    this.mowersApi = const MowersApi(),
    this.clientsApi = const ClientsApi(),
  });

  final Client client;
  final MowersApi mowersApi;
  final ClientsApi clientsApi;

  Future<bool> _showConfirmationDialog(BuildContext context, WidgetRef ref) async {
    final themeData = Theme.of(context);

    List<Mower> mowers = await mowersApi.fetchMowersForClient(ref.read(authProvider), client.id);

    // ignore: use_build_context_synchronously
    return await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          '¿Estas seguro?',
          style: themeData.textTheme.titleLarge!.copyWith(
            color: themeData.colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          mowers.isNotEmpty ? 'Este cliente tiene robots asignados!' : 'Este cliente no tiene robots asignados',
          style: themeData.textTheme.bodyMedium!.copyWith(
            color: themeData.colorScheme.onBackground,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(false);
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(true);
            },
            child: const Text('Si'),
          ),
        ],
      ),
    );
  }

  void _deleteClient(WidgetRef ref) async {
    await clientsApi.deleteClient(ref.read(authProvider), client.id);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: ValueKey(client.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return _showConfirmationDialog(context, ref);
      },
      onDismissed: (direction) async {
        if (direction == DismissDirection.endToStart) {
          _deleteClient(ref);
        }
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.delete, color: Colors.white),
            Text(
              'Borrar',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
      child: Card(
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
      ),
    );
  }
}
