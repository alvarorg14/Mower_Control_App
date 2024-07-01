import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mower_control_app/api/mowers.dart';
import 'package:mower_control_app/models/client.dart';
import 'package:mower_control_app/models/employee.dart';
import 'package:mower_control_app/models/mower.dart';
import 'package:mower_control_app/providers/auth_provider.dart';
import 'package:mower_control_app/providers/clients_provider.dart';
import 'package:mower_control_app/providers/employees_provider.dart';
import 'package:mower_control_app/providers/mowers_provider.dart';
import 'package:mower_control_app/providers/unassgined_mowers_provider.dart';
import 'package:mower_control_app/widgets/mower_information.dart';

const mowersApi = MowersApi();

class AssignMowerScreen extends ConsumerStatefulWidget {
  const AssignMowerScreen({super.key, required this.mower});

  final Mower mower;

  @override
  ConsumerState<AssignMowerScreen> createState() => _AssignMowerScreenState();
}

class _AssignMowerScreenState extends ConsumerState<AssignMowerScreen> {
  final _formKey = GlobalKey<FormState>();
  String? clientIdAssigned;
  String? employeeIdAssigned;

  var _isSending = false;

  void _saveClient() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });

      try {
        Mower mower = await mowersApi.assignMowerToClientAndEmployee(
          ref.read(authProvider),
          widget.mower.id,
          clientIdAssigned!,
          employeeIdAssigned!,
        );

        ref.read(mowersProvider.notifier).addMower(mower);
        ref.read(unassignedMowersProvider.notifier).removeMower(mower);

        if (!context.mounted) {
          return;
        }

        Navigator.of(context).pop();
      } catch (error) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      } finally {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Client> clients = ref.read(clientsProvider);
    List<Employee> employees = ref.read(employeesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asignar el robot'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              MowerInforamtion(mower: widget.mower),
              DropdownSearch<Client>(
                items: clients,
                selectedItem: widget.mower.client,
                itemAsString: (client) => client.name,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: const InputDecoration(
                    labelText: "Cliente",
                    hintText: "Selecciona un cliente",
                  ),
                  baseStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                popupProps: PopupProps.menu(
                  fit: FlexFit.tight,
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                    decoration: InputDecoration(
                      hintText: 'Busca aqui...',
                      hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                  ),
                ),
                validator: (client) {
                  if (client == null) {
                    return 'Selecciona un cliente';
                  }
                  return null;
                },
                onSaved: (client) {
                  clientIdAssigned = client!.id;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              DropdownSearch<Employee>(
                items: employees,
                selectedItem: widget.mower.employee,
                itemAsString: (employee) => '${employee.name} ${employee.surname1} ${employee.surname2}',
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: const InputDecoration(
                    labelText: "Empleado",
                    hintText: "Selecciona un empleado",
                  ),
                  baseStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                popupProps: PopupProps.menu(
                  fit: FlexFit.tight,
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                    decoration: InputDecoration(
                      hintText: 'Busca aqui...',
                      hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                  ),
                ),
                validator: (employee) {
                  if (employee == null) {
                    return 'Selecciona un empleado';
                  }
                  return null;
                },
                onSaved: (employee) {
                  employeeIdAssigned = employee!.id;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: _isSending ? null : _saveClient,
                child: _isSending
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(),
                      )
                    : const Text('Asignar robot'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
