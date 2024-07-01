import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mower_control_app/models/incidence.dart';
import 'package:mower_control_app/providers/auth_provider.dart';
import 'package:mower_control_app/providers/incidences_provider.dart';
import 'package:mower_control_app/api/incidences.dart';

const incidendesApi = IncidencesApi();

class IncidenceCard extends ConsumerWidget {
  const IncidenceCard({super.key, required this.incidence, required this.showSnackbar});

  final Incidence incidence;
  final Function showSnackbar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: ValueKey(incidence.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          ref.read(incidencesProvider.notifier).remove(incidence);
          incidendesApi.updateIncidenceReadedStatus(ref.read(authProvider), incidence);
          showSnackbar(context, incidence);
        }
      },
      background: Container(
        color: Colors.green,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.done, color: Colors.white),
            Text(
              'Leída',
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
                  incidence.message,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  DateFormat('dd-MM-yyyy HH:mm').format(incidence.date),
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
                    incidence.mower.name,
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
