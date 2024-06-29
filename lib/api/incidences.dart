import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mower_control_app/models/auth.dart';
import 'package:mower_control_app/models/incidence.dart';

class IncidencesApi {
  const IncidencesApi();

  Future<List<Incidence>> fetchIncidencesForEmployee(Auth auth, bool readed) async {
    final queryParams = {'readed': readed.toString()};
    final url = Uri.http(dotenv.env['MOWER_CONTROL_API_URL']!, '/incidences/employee/${auth.employeeId}', queryParams);

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': auth.token,
    });

    if (response.statusCode == 200) {
      List<dynamic> incidencesJson = json.decode(response.body);
      return incidencesJson.map((json) => Incidence.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load incidences!');
    }
  }

  void updateIncidenceReadedStatus(Auth auth, Incidence incidence) async {
    final url = Uri.http(dotenv.env['MOWER_CONTROL_API_URL']!, '/incidences/${incidence.id}');

    final response = await http.put(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': auth.token,
    });

    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to update incidence!');
    }
  }
}
