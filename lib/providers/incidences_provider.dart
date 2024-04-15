import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mower_control_app/models/incidence.dart';

class IncidencesProvider extends StateNotifier<List<Incidence>> {
  IncidencesProvider() : super([]);

  Incidence? _recentlyRemoved;
  int? _recentlyRemovedPos;

  void setIncidences(List<Incidence> incidences) {
    state = incidences;
  }

  void remove(Incidence incidence) {
    _recentlyRemovedPos = state.indexWhere((i) => i.id == incidence.id);
    if (_recentlyRemovedPos != -1) {
      _recentlyRemoved = state[_recentlyRemovedPos!];
      state = List<Incidence>.from(state)..removeAt(_recentlyRemovedPos!);
    }
  }

  void undoRemove() {
    if (_recentlyRemoved != null && _recentlyRemovedPos != null) {
      state = List<Incidence>.from(state)..insert(_recentlyRemovedPos!, _recentlyRemoved!);
      // Reset the variables after undoing
      _recentlyRemoved = null;
      _recentlyRemovedPos = null;
    }
  }
}

final incidencesProvider = StateNotifierProvider<IncidencesProvider, List<Incidence>>(
  (ref) => IncidencesProvider(),
);
