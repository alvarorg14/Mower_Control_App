import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mower_control_app/api/mowers.dart';
import 'package:mower_control_app/models/mower.dart';
import 'package:mower_control_app/providers/auth_provider.dart';
import 'package:mower_control_app/providers/mowers_provider.dart';
import 'package:mower_control_app/widgets/mower_card.dart';

const mowersApi = MowersApi();

class MowersScreen extends ConsumerStatefulWidget {
  const MowersScreen({super.key});

  @override
  ConsumerState<MowersScreen> createState() => _MowersScreenState();
}

class _MowersScreenState extends ConsumerState<MowersScreen> {
  List<Mower> mowers = [];
  String searchText = '';

  @override
  void initState() {
    super.initState();
    loadMowers();
  }

  void loadMowers() async {
    List<Mower> mowers =
        await mowersApi.fecthMowersForEmployee(ref.read(authProvider), ref.read(authProvider).employeeId);
    ref.read(mowersProvider.notifier).setMowers(mowers);
  }

  @override
  Widget build(BuildContext context) {
    List<Mower> filteredMowers = ref.watch(mowersProvider).where((mower) {
      return mower.name.toLowerCase().contains(searchText.toLowerCase()) ||
          mower.client!.name.toLowerCase().contains(searchText.toLowerCase()) ||
          mower.serialNumber.toString().contains(searchText);
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Buscar',
              suffixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredMowers.length,
            itemBuilder: (ctx, index) {
              Mower mower = filteredMowers[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: MowerCard(mower: mower),
              );
            },
          ),
        ),
      ],
    );
  }
}
