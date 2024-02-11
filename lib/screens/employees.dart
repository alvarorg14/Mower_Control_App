import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mower_control_app/api/employees.dart';
import 'package:mower_control_app/models/employee.dart';
import 'package:mower_control_app/providers/auth_provider.dart';
import 'package:mower_control_app/providers/employees_provider.dart';
import 'package:mower_control_app/widgets/employee_card.dart';

const employeesApi = EmployeesApi();

class EmployeesScreen extends ConsumerStatefulWidget {
  const EmployeesScreen({super.key});

  @override
  ConsumerState<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends ConsumerState<EmployeesScreen> {
  List<Employee> employees = [];

  @override
  void initState() {
    super.initState();
    loadEmployees();
  }

  void loadEmployees() async {
    List<Employee> employees = await employeesApi.fetchEmployeesForCompany(ref.read(authProvider));
    ref.read(employeesProvider.notifier).setEmployees(employees);
  }

  @override
  Widget build(BuildContext context) {
    employees = ref.watch(employeesProvider);
    //Don't show the current user in the list of employees
    List<Employee> employeesToShow =
        employees.where((employee) => employee.id != ref.read(authProvider).employeeId).toList();
    return ListView.builder(
      itemCount: employeesToShow.length,
      itemBuilder: (ctx, index) {
        Employee employee = employeesToShow[index];
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: EmployeeCard(employee: employee),
        );
      },
    );
  }
}
