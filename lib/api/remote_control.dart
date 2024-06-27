import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mower_control_app/models/auth.dart';

class RemoteControlApi {
  const RemoteControlApi();

  Future<void> sendMowAction(Auth auth, String mowerId) async {
    final url = Uri.http(dotenv.env['MOWER_CONTROL_API_URL']!, '/action/mow/$mowerId');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': auth.token,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send mow action!');
    }
  }

  Future<void> sendChargeAction(Auth auth, String mowerId) async {
    final url = Uri.http(dotenv.env['MOWER_CONTROL_API_URL']!, '/action/charge/$mowerId');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': auth.token,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send charge action!');
    }
  }

  Future<void> sendPauseAction(Auth auth, String mowerId) async {
    final url = Uri.http(dotenv.env['MOWER_CONTROL_API_URL']!, '/action/pause/$mowerId');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': auth.token,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send pause action!');
    }
  }
}
