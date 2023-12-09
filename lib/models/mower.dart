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
  final String modelId;
  final String? clientId;
  final String? employeeId;
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
    required this.modelId,
    required this.clientId,
    required this.employeeId,
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
      modelId: json['modelId'],
      clientId: json['clientId'],
      employeeId: json['employeeId'],
      companyId: json['companyId'],
    );
  }
}
