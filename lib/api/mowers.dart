import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mower_control_app/models/mower.dart';
import 'package:http/http.dart' as http;
import 'package:mower_control_app/models/auth.dart';

class MowersApi {
  const MowersApi();

  Future<List<Mower>> fecthMowersForCompany(Auth auth, bool assigned) async {
    final queryParams = {'assigned': assigned.toString()};
    final url = Uri.http(dotenv.env['MOWER_CONTROL_API_URL']!, '/robots/company/${auth.companyId}', queryParams);
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': auth.token,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> mowersJson = json.decode(response.body);
      return mowersJson.map((json) => Mower.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load mowers');
    }
  }

  Future<Mower> assignMowerToClientAndEmployee(Auth auth, String mowerId, String clientId, String employeeId) async {
    final url = Uri.http(dotenv.env['MOWER_CONTROL_API_URL']!, '/robots/$mowerId/assign');
    Map<String, dynamic> bodyMap = {
      'clientId': clientId,
      'employeeId': employeeId,
    };
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': auth.token,
      },
      body: json.encode(bodyMap),
    );

    if (response.statusCode == 200) {
      dynamic mowerJson = json.decode(response.body);
      return Mower.fromJson(mowerJson);
    } else {
      throw Exception('Failed to load mowers');
    }
  }

  Future<List<Mower>> fetchMowersForClient(Auth auth, String clientId) async {
    final url = Uri.http(dotenv.env['MOWER_CONTROL_API_URL']!, '/robots/client/$clientId');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': auth.token,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> mowersJson = json.decode(response.body);
      return mowersJson.map((json) => Mower.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load mowers');
    }
  }

  Future<List<Mower>> fecthMowersForEmployee(Auth auth, String employeeId) async {
    final url = Uri.http(dotenv.env['MOWER_CONTROL_API_URL']!, '/robots/employee/$employeeId');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': auth.token,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> mowersJson = json.decode(response.body);
      return mowersJson.map((json) => Mower.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load mowers');
    }
  }
}
