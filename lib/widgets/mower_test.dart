import 'package:flutter/material.dart';
import 'package:mower_control_app/models/mower.dart';
import 'package:mower_control_app/widgets/battery.dart';
import 'package:mower_control_app/widgets/mower_status.dart';

class MowerTest extends StatelessWidget {
  const MowerTest({super.key, required this.mower});

  final Mower mower;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.only(
          left: 30,
          top: 16,
          bottom: 16,
          right: 16,
        ),
        height: 175,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MowerStatus(
              mower: mower,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Battery(battery: mower.battery),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${mower.name}',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      '405X - ${mower.serialNumber}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
