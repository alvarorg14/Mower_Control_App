import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mower_control_app/api/clients.dart';
import 'package:mower_control_app/models/client.dart';
import 'package:mower_control_app/providers/auth_provider.dart';
import 'package:mower_control_app/providers/clients_provider.dart';

const clientsApi = ClientsApi();

class NewClient extends ConsumerStatefulWidget {
  const NewClient({super.key});

  @override
  ConsumerState<NewClient> createState() {
    return _NewClientState();
  }
}

class _NewClientState extends ConsumerState<NewClient> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredAddress = '';
  var _enteredNumber = 0;
  var _isSending = false;

  void _saveClient() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });

      try {
        Client client = await clientsApi.createClient(
          ref.read(authProvider),
          _enteredName,
          _enteredAddress,
          _enteredNumber,
        );

        ref.read(clientsProvider.notifier).addClient(client);

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new client'),
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
                decoration: const InputDecoration(labelText: 'Name'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a name';
                  }
                  if (value.trim().length < 4 || value.trim().length > 40) {
                    return 'Name must be between 4 and 40 characters long';
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
                decoration: const InputDecoration(labelText: 'Address'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter an address';
                  }
                  if (value.trim().length < 10 || value.trim().length > 100) {
                    return 'Address must be between 10 and 100 characters long';
                  }

                  return null;
                },
                onSaved: (value) {
                  _enteredAddress = value!;
                },
              ),
              TextFormField(
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                decoration: const InputDecoration(labelText: 'Phone Number'),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a number';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  if (int.parse(value) <= 0) {
                    return 'Please enter a number greater than zero';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredNumber = int.parse(value!);
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
                    : const Text('Add Client'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
