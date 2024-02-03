import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mower_control_app/models/employee.dart';

class EmployeesProvider extends StateNotifier<List<Employee>> {
  EmployeesProvider() : super([]);

  void setEmployees(List<Employee> employees) {
    state = employees;
  }

  void addEmployee(Employee employee) {
    state = [...state, employee];
  }
}

final employeesProvider = StateNotifierProvider<EmployeesProvider, List<Employee>>(
  (ref) => EmployeesProvider(),
);
