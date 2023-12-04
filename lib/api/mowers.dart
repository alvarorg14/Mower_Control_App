import 'dart:convert';

import 'package:mower_control_app/models/mower.dart';
import 'package:http/http.dart' as http;
import 'package:mower_control_app/models/auth.dart';

class MowersApi {
  const MowersApi();

  Future<List<Mower>> fecthMowersForCompany(Auth auth) async {
    final url = Uri.http('localhost:8080', '/robots/company/${auth.companyId}');

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': auth.token,
    });

    if (response.statusCode == 200) {
      List<dynamic> mowersJson = json.decode(response.body);
      return mowersJson.map((json) => Mower.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load mowers');
    }
  }
}
