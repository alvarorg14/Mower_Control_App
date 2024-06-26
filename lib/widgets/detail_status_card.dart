import 'package:flutter/material.dart';
import 'package:mower_control_app/utils/status.dart';

const statusUtils = StatusUtils();

class MowerDetailStatus extends StatelessWidget {
  const MowerDetailStatus({
    super.key,
    required this.battery,
    required this.mode,
    required this.activity,
    required this.state,
    required this.modelName,
  });

  final int battery;
  final String mode;
  final String activity;
  final String state;
  final String modelName;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(
            'Estado actual',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: statusUtils.getColorForStatus(activity),
                    width: 3.0,
                  ),
                ),
                child: ClipOval(
                  child: Image.asset('assets/images/$modelName.png'),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bateria: $battery %',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Modo: ${statusUtils.getTextForMode(mode)}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Acitvidad: ${statusUtils.getTextForActivity(activity)}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Estado: ${statusUtils.getTextForState(state)}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
