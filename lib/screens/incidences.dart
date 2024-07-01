import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mower_control_app/api/incidences.dart';
import 'package:mower_control_app/models/incidence.dart';
import 'package:mower_control_app/providers/auth_provider.dart';
import 'package:mower_control_app/providers/incidences_provider.dart';
import 'package:mower_control_app/widgets/incidence_card.dart';

const incidencesApi = IncidencesApi();

class IncidencesScreen extends ConsumerStatefulWidget {
  const IncidencesScreen({super.key});

  @override
  ConsumerState<IncidencesScreen> createState() {
    return _IncidencesScreenState();
  }
}

class _IncidencesScreenState extends ConsumerState<IncidencesScreen> {
  List<Incidence> incidences = [];

  @override
  void initState() {
    super.initState();
    loadIncidences();
  }

  void showSnackBar(BuildContext context, Incidence incidence) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Incidencia leída"),
        action: SnackBarAction(
          label: "DESHACER",
          onPressed: () {
            ref.read(incidencesProvider.notifier).undoRemove();
            incidencesApi.updateIncidenceReadedStatus(ref.read(authProvider), incidence);
          },
        ),
      ),
    );
  }

  void loadIncidences() async {
    List<Incidence> incidences = await incidencesApi.fetchIncidencesForEmployee(ref.read(authProvider), false);
    ref.read(incidencesProvider.notifier).setIncidences(incidences);
  }

  @override
  Widget build(BuildContext context) {
    incidences = ref.watch(incidencesProvider);
    return ListView.builder(
      itemCount: incidences.length,
      itemBuilder: (ctx, index) {
        Incidence incidence = incidences[index];
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: IncidenceCard(
            incidence: incidence,
            showSnackbar: showSnackBar,
          ),
        );
      },
    );
  }
}
