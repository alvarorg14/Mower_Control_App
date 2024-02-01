import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mower_control_app/models/client.dart';

class ClientsProvider extends StateNotifier<List<Client>> {
  ClientsProvider() : super([]);

  void setClients(List<Client> clients) {
    state = clients;
  }

  void addClient(Client client) {
    state = [...state, client];
  }
}

final clientsProvider = StateNotifierProvider<ClientsProvider, List<Client>>(
  (ref) => ClientsProvider(),
);
