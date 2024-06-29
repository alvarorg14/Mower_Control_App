import 'package:flutter/material.dart';
import 'package:mower_control_app/models/mower.dart';
import 'package:mower_control_app/utils/status.dart';

const statusUtils = StatusUtils();

class MowerStatus extends StatelessWidget {
  const MowerStatus({super.key, required this.mower});

  final Mower mower;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: statusUtils.getColorForStatus(mower.activity),
              width: 3.0,
            ),
          ),
          child: ClipOval(
            child: Image.asset('assets/images/${mower.model.name}.png'),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          statusUtils.getTextForActivity(mower.activity, mower.state).toUpperCase(),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ],
    );
  }
}
