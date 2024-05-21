import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mower_control_app/models/auth.dart';
import 'package:mower_control_app/providers/auth_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const storage = FlutterSecureStorage();

class AuthApi {
  const AuthApi();

  Future<void> addDevice(String userId, String deviceId) async {
    final url = Uri.http(dotenv.env['MOWER_CONTROL_API_URL']!, '/device');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'employeeId': userId,
        'deviceId': deviceId,
      }),
    );

    if (response.statusCode != 200) {
      throw Error();
    }
  }

  void login(WidgetRef ref, String username, String password) async {
    final url = Uri.http(dotenv.env['MOWER_CONTROL_API_URL']!, '/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    final Map<String, dynamic> resData = json.decode(response.body);

    var auth = Auth(
      token: resData['token'],
      employeeId: resData['employeeId'],
      companyId: resData['companyId'],
    );

    await storage.write(key: 'token', value: auth.token);
    await storage.write(key: 'employeeId', value: auth.employeeId);
    await storage.write(key: 'companyId', value: auth.companyId);

    ref.read(authProvider.notifier).setAuth(auth);
  }

  Future<void> signup(
    WidgetRef ref,
    String companyName,
    String cif,
    String name,
    String surname1,
    String surname2,
    String username,
    String password,
    String code,
    String state,
  ) async {
    final url = Uri.http(dotenv.env['MOWER_CONTROL_API_URL']!, '/signup');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'companyName': companyName,
        'cif': cif,
        'name': name,
        'surname1': surname1,
        'surname2': surname2,
        'username': username,
        'password': password,
        'code': code,
        'state': state,
      }),
    );

    final Map<String, dynamic> resData = json.decode(response.body);

    if (response.statusCode != 200) {
      throw resData['reason'];
    }

    var auth = Auth(
      token: resData['token'],
      employeeId: resData['employeeId'],
      companyId: resData['companyId'],
    );

    await storage.write(key: 'token', value: auth.token);
    await storage.write(key: 'employeeId', value: auth.employeeId);
    await storage.write(key: 'companyId', value: auth.companyId);

    ref.read(authProvider.notifier).setAuth(auth);
  }
}
