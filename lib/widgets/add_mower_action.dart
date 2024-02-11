import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mower_control_app/api/mowers.dart';
import 'package:mower_control_app/models/mower.dart';
import 'package:mower_control_app/providers/auth_provider.dart';
import 'package:mower_control_app/providers/unassgined_mowers_provider.dart';
import 'package:mower_control_app/screens/unassigned_mowers.dart';

const mowersApi = MowersApi();

class AddMowerAction extends ConsumerStatefulWidget {
  const AddMowerAction({super.key});

  @override
  ConsumerState<AddMowerAction> createState() => _AddMowerActionState();
}

class _AddMowerActionState extends ConsumerState<AddMowerAction> {
  List<Mower> mowers = [];

  @override
  void initState() {
    super.initState();
    loadMowers();
  }

  void loadMowers() async {
    List<Mower> mowers = await mowersApi.fecthMowersForCompany(ref.read(authProvider), false);
    ref.read(unassignedMowersProvider.notifier).setMowers(mowers);
  }

  void _openUnassginedMowersScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const UnassignedMowersScreen()));
  }

  @override
  Widget build(BuildContext context) {
    mowers = ref.watch(unassignedMowersProvider);

    return Stack(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _openUnassginedMowersScreen,
        ),
        Positioned(
          right: 3,
          top: 0,
          child: Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6),
            ),
            constraints: const BoxConstraints(
              minWidth: 12,
              minHeight: 12,
            ),
            child: Text(
              '${mowers.length}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
