import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mower_control_app/models/employee.dart';
import 'package:http/http.dart' as http;
import 'package:mower_control_app/models/auth.dart';

class EmployeesApi {
  const EmployeesApi();

  Future<List<Employee>> fetchEmployeesForCompany(Auth auth) async {
    final url = Uri.http(dotenv.env['MOWER_CONTROL_API_URL']!, '/employees/company/${auth.companyId}');

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': auth.token,
    });

    if (response.statusCode == 200) {
      List<dynamic> employeesJson = json.decode(response.body);
      return employeesJson.map((json) => Employee.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load employees!');
    }
  }

  Future<Employee> createEmployee(Auth auth, String name, String surname1, String? surname2) async {
    final url = Uri.http(dotenv.env['MOWER_CONTROL_API_URL']!, '/employees/${auth.companyId}');

    Map<String, dynamic> bodyMap = {
      'name': name,
      'surname1': surname1,
    };

    if (surname2 != null && surname2.trim().isNotEmpty) {
      bodyMap['surname2'] = surname2;
    }

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': auth.token,
      },
      body: json.encode(bodyMap),
    );

    if (response.statusCode == 201) {
      return Employee.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create employee!');
    }
  }

  Future<void> deleteEmployee(Auth auth, String employeeId) async {
    final url = Uri.http(dotenv.env['MOWER_CONTROL_API_URL']!, '/employees/$employeeId');

    final response = await http.delete(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': auth.token,
    });

    if (response.statusCode != 204) {
      throw Exception('Failed to delete employee!');
    }
  }
}
