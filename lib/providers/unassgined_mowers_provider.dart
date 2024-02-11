import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mower_control_app/models/mower.dart';

class UnassignedMowersProvider extends StateNotifier<List<Mower>> {
  UnassignedMowersProvider() : super([]);

  void setMowers(List<Mower> mowers) {
    state = mowers;
  }

  void addMower(Mower mower) {
    state = [...state, mower];
  }

  void removeMower(Mower mower) {
    state = state.where((m) => m.id != mower.id).toList();
  }
}

final unassignedMowersProvider = StateNotifierProvider<UnassignedMowersProvider, List<Mower>>(
  (ref) => UnassignedMowersProvider(),
);
