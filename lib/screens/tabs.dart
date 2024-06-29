import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mower_control_app/providers/auth_provider.dart';
import 'package:mower_control_app/screens/clients.dart';
import 'package:mower_control_app/screens/incidences.dart';
import 'package:mower_control_app/screens/mowers.dart';
import 'package:mower_control_app/screens/employees.dart';
import 'package:mower_control_app/screens/profile.dart';
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
    List<Mower> mowers =
        await mowersApi.fecthMowersForEmployee(ref.read(authProvider), ref.read(authProvider).employeeId);
    ref.read(mowersProvider.notifier).setMowers(mowers);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String role = ref.read(authProvider).role;
    bool isAdmin = role == 'admin';

    Widget activePage = const MowersScreen();
    var activePageTitle = 'Mowers';
    List<Widget> activeActions = [
      IconButton(
        onPressed: updateRobots,
        icon: const Icon(Icons.autorenew),
      ),
      if (isAdmin) const AddMowerAction(),
    ];

    List<Map<String, dynamic>> pages = [
      {
        'title': 'Mowers',
        'icon': Icons.home,
        'page': const MowersScreen(),
        'actions': [
          IconButton(
            onPressed: updateRobots,
            icon: const Icon(Icons.autorenew),
          ),
          if (isAdmin) const AddMowerAction(),
        ],
      },
      {
        'title': 'Clients',
        'icon': Icons.person,
        'page': const ClientsScreen(),
        'actions': [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddClientWidget,
          ),
        ],
      },
      {
        'title': 'Employees',
        'icon': Icons.engineering,
        'page': const EmployeesScreen(),
        'actions': [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddEmployeeWidget,
          ),
        ],
      },
      {
        'title': 'Incidences',
        'icon': Icons.warning_rounded,
        'page': const IncidencesScreen(),
        'actions': [
          IconButton(
            onPressed: updateRobots,
            icon: const Icon(Icons.autorenew),
          ),
        ],
      },
      {
        'title': 'Profile',
        'icon': Icons.settings,
        'page': const ProfileScreen(),
        'actions': [],
      },
    ];

    if (!isAdmin) {
      pages.removeWhere((page) => page['title'] == 'Clients' || page['title'] == 'Employees');
    }

    if (_selectedPageIndex >= pages.length) {
      _selectedPageIndex = 0;
    }

    activePage = pages[_selectedPageIndex]['page'];
    activePageTitle = pages[_selectedPageIndex]['title'];
    activeActions = List<Widget>.from(pages[_selectedPageIndex]['actions']);

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
        items: pages
            .map((page) => BottomNavigationBarItem(
                  icon: Icon(page['icon']),
                  label: page['title'],
                ))
            .toList(),
      ),
    );
  }
}
