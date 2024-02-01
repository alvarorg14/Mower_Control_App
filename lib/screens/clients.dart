import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mower_control_app/api/clients.dart';
import 'package:mower_control_app/models/client.dart';
import 'package:mower_control_app/providers/auth_provider.dart';
import 'package:mower_control_app/providers/clients_provider.dart';
import 'package:mower_control_app/widgets/client_card.dart';

const clientsApi = ClientsApi();

class ClientsScreen extends ConsumerStatefulWidget {
  const ClientsScreen({super.key});

  @override
  ConsumerState<ClientsScreen> createState() {
    return _ClientsScreenState();
  }
}

class _ClientsScreenState extends ConsumerState<ClientsScreen> {
  List<Client> clients = [];

  @override
  void initState() {
    super.initState();
    loadClients();
  }

  void loadClients() async {
    List<Client> clients = await clientsApi.fetchClientsForCompany(ref.read(authProvider));
    ref.read(clientsProvider.notifier).setClients(clients);
  }

  @override
  Widget build(BuildContext context) {
    clients = ref.watch(clientsProvider);
    return ListView.builder(
      itemCount: clients.length,
      itemBuilder: (ctx, index) {
        Client client = clients[index];
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: ClientCard(client: client),
        );
      },
    );
  }
}
