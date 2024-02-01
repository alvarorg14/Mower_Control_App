import 'dart:convert';

import 'package:mower_control_app/models/client.dart';
import 'package:http/http.dart' as http;
import 'package:mower_control_app/models/auth.dart';

class ClientsApi {
  const ClientsApi();

  Future<List<Client>> fetchClientsForCompany(Auth auth) async {
    final url = Uri.http('10.0.2.2:8080', '/clients/company/${auth.companyId}');

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': auth.token,
    });

    if (response.statusCode == 200) {
      List<dynamic> clientsJson = json.decode(response.body);
      return clientsJson.map((json) => Client.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load clients!');
    }
  }

  Future<Client> createClient(Auth auth, String name, String address, int phoneNumber) async {
    final url = Uri.http('10.0.2.2:8080', '/clients');

    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': auth.token,
        },
        body: json.encode({
          'name': name,
          'address': address,
          'phoneNumber': phoneNumber,
        }));

    if (response.statusCode == 201) {
      return Client.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create client!');
    }
  }
}
