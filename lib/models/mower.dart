import 'package:mower_control_app/models/client.dart';
import 'package:mower_control_app/models/employee.dart';
import 'package:mower_control_app/models/model.dart';

class Mower {
  final String id;
  final int serialNumber;
  final String name;
  final int battery;
  final String mode;
  final String activity;
  final String state;
  final int errorCode;
  final int errorCodeTimestamp;
  final bool assigned;
  final Model model;
  final Client? client;
  final Employee? employee;
  final String companyId;

  Mower({
    required this.id,
    required this.serialNumber,
    required this.name,
    required this.battery,
    required this.mode,
    required this.activity,
    required this.state,
    required this.errorCode,
    required this.errorCodeTimestamp,
    required this.assigned,
    required this.model,
    required this.client,
    required this.employee,
    required this.companyId,
  });

  factory Mower.fromJson(Map<String, dynamic> json) {
    return Mower(
      id: json['robotId'],
      serialNumber: json['serialNumber'],
      name: json['name'],
      battery: json['battery'],
      mode: json['mode'],
      activity: json['activity'],
      state: json['state'],
      errorCode: json['errorCode'],
      errorCodeTimestamp: json['errorCodeTimestamp'],
      assigned: json['assigned'] == 1,
      model: Model.fromJson(json['model']),
      client: json['client'] != null ? Client.fromJson(json['client']) : null,
      employee: json['employee'] != null ? Employee.fromJson(json['employee']) : null,
      companyId: json['companyId'],
    );
  }
}
