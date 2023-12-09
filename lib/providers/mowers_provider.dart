import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mower_control_app/models/mower.dart';

class MowersProvider extends StateNotifier<List<Mower>> {
  MowersProvider() : super([]);

  void setMowers(List<Mower> mowers) {
    state = mowers;
  }

  void addMower(Mower mower) {
    state = [...state, mower];
  }
}

final mowersProvider = StateNotifierProvider<MowersProvider, List<Mower>>(
  (ref) => MowersProvider(),
);
