class Client {
  final String id;
  final String name;
  final String address;
  final int phoneNumber;
  final String companyId;

  Client({
    required this.id,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.companyId,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['clientId'],
      name: json['name'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      companyId: json['companyId'],
    );
  }
}
