import 'package:mower_control_app/models/mower.dart';

class Incidence {
  final String id;
  final int code;
  final String message;
  final DateTime date;
  final Mower mower;
  final bool readed;

  Incidence({
    required this.id,
    required this.code,
    required this.message,
    required this.date,
    required this.mower,
    required this.readed,
  });

  factory Incidence.fromJson(Map<String, dynamic> json) {
    return Incidence(
      id: json['incidenceId'],
      code: json['code'],
      message: json['message'],
      date: DateTime.fromMillisecondsSinceEpoch(
        json['timestamp'],
      ),
      mower: Mower.fromJson(json['robot']),
      readed: json['readed'] == 1,
    );
  }
}
