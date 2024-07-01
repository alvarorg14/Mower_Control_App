import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mower_control_app/api/employees.dart';
import 'package:mower_control_app/models/employee.dart';
import 'package:mower_control_app/providers/auth_provider.dart';
import 'package:mower_control_app/providers/employees_provider.dart';

const employeesApi = EmployeesApi();

class NewEmployee extends ConsumerStatefulWidget {
  const NewEmployee({super.key});

  @override
  ConsumerState<NewEmployee> createState() {
    return _NewEmployeeState();
  }
}

class _NewEmployeeState extends ConsumerState<NewEmployee> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredSurname1 = '';
  String? _enteredSurname2;
  var _isSending = false;

  void _saveEmployee() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });

      try {
        Employee employee = await employeesApi.createEmployee(
          ref.read(authProvider),
          _enteredName,
          _enteredSurname1,
          _enteredSurname2,
        );

        ref.read(employeesProvider.notifier).addEmployee(employee);

        if (!context.mounted) {
          return;
        }

        _showAlertDialog(context, employee);
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

  void _showAlertDialog(BuildContext context, Employee employee) {
    Widget okButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text('OK'),
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        'Guarda estas credenciales!',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18,
            ),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Usuario: ${employee.username}',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          Text(
            'Contraseña: ${employee.password}',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
      actions: [
        okButton,
      ],
    );

    showDialog(context: context, builder: (ctx) => alert).then(
      (_) => Navigator.of(context).pop(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear un nuevo empleado'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                decoration: const InputDecoration(labelText: 'Nombre'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduzca un nombre válido';
                  }
                  if (value.trim().length < 3 || value.trim().length > 50) {
                    return 'El nombre tiene que tener entre 3 y 50 caracteres';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredName = value!;
                },
              ),
              TextFormField(
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                decoration: const InputDecoration(labelText: 'Primer apellido'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduzca un apellido válido';
                  }
                  if (value.trim().length < 3 || value.trim().length > 50) {
                    return 'El apellido tiene que tener entre 3 y 50 caraceters';
                  }

                  return null;
                },
                onSaved: (value) {
                  _enteredSurname1 = value!;
                },
              ),
              TextFormField(
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                decoration: const InputDecoration(labelText: 'Segundo apellido (opcional)'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return null;
                  }
                  if (value.trim().length < 3 || value.trim().length > 50) {
                    return 'El apellido tiene que tener entre 3 y 50 caracteres';
                  }

                  return null;
                },
                onSaved: (value) {
                  _enteredSurname2 = value!;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: _isSending ? null : _saveEmployee,
                child: _isSending
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(),
                      )
                    : const Text('Añadir empleado'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
