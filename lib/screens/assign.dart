import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mower_control_app/models/client.dart';
import 'package:mower_control_app/providers/clients_provider.dart';

class AssignScreen extends ConsumerWidget {
  const AssignScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Client> clients = ref.read(clientsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assign the mower'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownSearch<Client>(
              items: clients,
              onChanged: print,
              selectedItem: null,
              itemAsString: (client) => client.name,
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Client",
                  hintText: "Select a client",
                ),
              ),
              popupProps: const PopupProps.menu(
                fit: FlexFit.tight,
                showSearchBox: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
