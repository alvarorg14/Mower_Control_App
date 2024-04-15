import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mower_control_app/screens/clients.dart';
import 'package:mower_control_app/screens/incidences.dart';
import 'package:mower_control_app/screens/mowers.dart';
import 'package:mower_control_app/screens/employees.dart';
import 'package:mower_control_app/screens/unassigned_mowers.dart';
import 'package:mower_control_app/widgets/add_mower_action.dart';
import 'package:mower_control_app/screens/new_client.dart';
import 'package:mower_control_app/screens/new_employee.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _openAddClientWidget() {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const NewClient()));
  }

  void _openAddEmployeeWidget() {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const NewEmployee()));
  }

  void _openUnassginedMowersScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const UnassignedMowersScreen()));
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const MowersScreen();
    var activePageTitle = 'Mowers';
    List<Widget> activeActions = [
      const AddMowerAction(),
    ];

    if (_selectedPageIndex == 1) {
      activePage = const ClientsScreen();
      activePageTitle = 'Clients';
      activeActions = [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _openAddClientWidget,
        ),
      ];
    } else if (_selectedPageIndex == 2) {
      activePage = const EmployeesScreen();
      activePageTitle = 'Employees';
      activeActions = [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _openAddEmployeeWidget,
        ),
      ];
    } else if (_selectedPageIndex == 3) {
      activePage = const IncidencesScreen();
      activePageTitle = 'Incidences';
      activeActions = [];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
        actions: activeActions,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onBackground,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Mowers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Clients',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.engineering),
            label: 'Employees',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning_rounded),
            label: 'Incidences',
          ),
        ],
      ),
    );
  }
}
