import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mower_control_app/providers/auth_provider.dart';
import 'package:mower_control_app/screens/clients.dart';
import 'package:mower_control_app/screens/incidences.dart';
import 'package:mower_control_app/screens/mowers.dart';
import 'package:mower_control_app/screens/employees.dart';
import 'package:mower_control_app/screens/profile.dart';
import 'package:mower_control_app/screens/unassigned_mowers.dart';
import 'package:mower_control_app/widgets/add_mower_action.dart';
import 'package:mower_control_app/screens/new_client.dart';
import 'package:mower_control_app/screens/new_employee.dart';
import 'package:mower_control_app/api/mowers.dart';
import 'package:mower_control_app/models/mower.dart';
import 'package:mower_control_app/providers/mowers_provider.dart';

const mowersApi = MowersApi();

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  var _isLoading = false;

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

  void updateRobots() async {
    setState(() {
      _isLoading = true;
    });
    await mowersApi.updateRobotsForCompany(ref.read(authProvider));
    List<Mower> mowers = await mowersApi.fecthMowersForCompany(ref.read(authProvider), true);
    ref.read(mowersProvider.notifier).setMowers(mowers);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const MowersScreen();
    var activePageTitle = 'Mowers';
    List<Widget> activeActions = [
      IconButton(
        onPressed: updateRobots,
        icon: const Icon(Icons.autorenew),
      ),
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
      activeActions = [
        IconButton(
          onPressed: updateRobots,
          icon: const Icon(Icons.autorenew),
        ),
      ];
    } else if (_selectedPageIndex == 4) {
      activePage = const ProfileScreen();
      activePageTitle = 'Profile';
      activeActions = [];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
        actions: activeActions,
      ),
      body: Stack(
        children: [
          activePage,
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
