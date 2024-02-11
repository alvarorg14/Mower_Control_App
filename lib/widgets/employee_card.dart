import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mower_control_app/api/employees.dart';
import 'package:mower_control_app/api/mowers.dart';
import 'package:mower_control_app/models/employee.dart';
import 'package:mower_control_app/models/mower.dart';
import 'package:mower_control_app/providers/auth_provider.dart';

const mowersApi = MowersApi();
const employeesApi = EmployeesApi();

class EmployeeCard extends ConsumerWidget {
  const EmployeeCard({super.key, required this.employee});

  final Employee employee;

  Future<bool> _showConfirmationDialog(BuildContext context, WidgetRef ref) async {
    final themeData = Theme.of(context);

    List<Mower> mowers = await mowersApi.fecthMowersForEmployee(ref.read(authProvider), employee.id);

    // ignore: use_build_context_synchronously
    return await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Are you sure?',
          style: themeData.textTheme.titleLarge!.copyWith(
            color: themeData.colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          mowers.isNotEmpty
              ? 'This employee has mowers assigned to it!'
              : 'This employee has no mowers assigned to it.',
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
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  void _deleteEmployee(WidgetRef ref) async {
    await employeesApi.deleteEmployee(ref.read(authProvider), employee.id);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: ValueKey(employee.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return _showConfirmationDialog(context, ref);
      },
      onDismissed: (direction) async {
        if (direction == DismissDirection.endToStart) {
          _deleteEmployee(ref);
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
              'Delete',
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '${employee.name} ${employee.surname1} ${employee.surname2 ?? ''}',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                employee.username,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
