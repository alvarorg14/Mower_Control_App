class Employee {
  final String id;
  final String name;
  final String surname1;
  final String? surname2;
  final String username;
  final String password;
  final String companyId;

  Employee({
    required this.id,
    required this.name,
    required this.surname1,
    this.surname2,
    required this.username,
    required this.password,
    required this.companyId,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['employeeId'],
      name: json['name'],
      surname1: json['surname1'],
      surname2: json['surname2'],
      username: json['username'],
      password: json['password'],
      companyId: json['companyId'],
    );
  }
}
