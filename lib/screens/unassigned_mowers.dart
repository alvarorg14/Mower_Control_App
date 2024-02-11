import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mower_control_app/api/mowers.dart';
import 'package:mower_control_app/models/mower.dart';
import 'package:mower_control_app/providers/auth_provider.dart';
import 'package:mower_control_app/widgets/unassigned_mower_card.dart';

const mowersApi = MowersApi();

class UnassignedMowersScreen extends ConsumerStatefulWidget {
  const UnassignedMowersScreen({super.key});

  @override
  ConsumerState<UnassignedMowersScreen> createState() => _UnassginedMowersScreenState();
}

class _UnassginedMowersScreenState extends ConsumerState<UnassignedMowersScreen> {
  late Future<List<Mower>> _futureMowers;

  @override
  void initState() {
    super.initState();
    _futureMowers = mowersApi.fecthMowersForCompany(ref.read(authProvider), false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unassigned Mowers'),
      ),
      body: FutureBuilder(
        future: _futureMowers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong!'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No unassgined mowers found!'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx, index) {
              Mower mower = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                child: UnassignedMowerCard(mower: mower),
              );
            },
          );
        },
      ),
    );
  }
}
