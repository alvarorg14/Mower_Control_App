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

  @override
  void initState() {
    super.initState();
    loadMowers();
  }

  void loadMowers() async {
    List<Mower> mowers = await mowersApi.fecthMowersForCompany(ref.read(authProvider), true);
    ref.read(mowersProvider.notifier).setMowers(mowers);
  }

  @override
  Widget build(BuildContext context) {
    mowers = ref.watch(mowersProvider);

    return ListView.builder(
      itemCount: mowers.length,
      itemBuilder: (ctx, index) {
        Mower mower = mowers[index];
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: MowerCard(mower: mower),
        );
      },
    );
  }
}
