import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mower_control_app/screens/clients.dart';
import 'package:mower_control_app/screens/mowers.dart';
import 'package:mower_control_app/screens/parts.dart';
import 'package:mower_control_app/widgets/new_client.dart';

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

  @override
  Widget build(BuildContext context) {
    Widget activePage = const MowersScreen();
    var activePageTitle = 'Mowers';
    List<Widget> activeActions = [];

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
      activePage = const PartsScreen();
      activePageTitle = 'Repair Parts';
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
            icon: Icon(Icons.settings),
            label: 'Parts',
          ),
        ],
      ),
    );
  }
}
