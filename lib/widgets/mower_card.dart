import 'package:flutter/material.dart';
import 'package:mower_control_app/models/mower.dart';
import 'package:mower_control_app/screens/mower_details.dart';
import 'package:mower_control_app/widgets/battery.dart';
import 'package:mower_control_app/widgets/mower_status.dart';

class MowerCard extends StatelessWidget {
  const MowerCard({super.key, required this.mower});

  final Mower mower;

  void _showMowerDetailsScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MowerDetailsScreen(mower: mower),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showMowerDetailsScreen(context),
      child: Card(
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
                      child: Column(
                        children: [
                          Text(
                            mower.client!.name,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            mower.name,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Theme.of(context).colorScheme.onBackground,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        '${mower.model.name} - ${mower.serialNumber}',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
      ),
    );
  }
}
