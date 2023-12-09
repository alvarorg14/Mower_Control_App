import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mower_control_app/api/mowers.dart';
import 'package:mower_control_app/models/mower.dart';
import 'package:mower_control_app/providers/auth_provider.dart';
import 'package:mower_control_app/widgets/mower_card.dart';
import 'package:mower_control_app/widgets/mower_test.dart';

const mowersApi = MowersApi();

class MowersScreen extends ConsumerStatefulWidget {
  const MowersScreen({super.key});

  @override
  ConsumerState<MowersScreen> createState() => _MowersScreenState();
}

class _MowersScreenState extends ConsumerState<MowersScreen> {
  late Future<List<Mower>> _futureMowers;

  @override
  void initState() {
    super.initState();
    _futureMowers = mowersApi.fecthMowersForCompany(ref.read(authProvider));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureMowers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong!'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No mowers found!'));
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
              child: MowerTest(mower: mower),
            );
          },
        );
      },
    );
  }
}
