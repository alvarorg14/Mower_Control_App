import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mower_control_app/api/remote_control.dart';
import 'package:mower_control_app/models/auth.dart';
import 'package:mower_control_app/providers/auth_provider.dart';

const remoteControlApi = RemoteControlApi();

class RemoteControl extends ConsumerWidget {
  const RemoteControl({
    super.key,
    required this.mowerId,
  });

  final String mowerId;

  void sendMowAction(Auth auth) async {
    await remoteControlApi.sendMowAction(auth, mowerId);
  }

  void sendChargeAction(Auth auth) async {
    await remoteControlApi.sendChargeAction(auth, mowerId);
  }

  void sendPauseAction(Auth auth) async {
    await remoteControlApi.sendPauseAction(auth, mowerId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color buttonsBackgroundColor = Theme.of(context).colorScheme.secondary;
    Color buttonsTextColor = Theme.of(context).colorScheme.onSecondary;
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Control remoto',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  icon: Icon(
                    Icons.stop,
                    color: buttonsTextColor,
                  ),
                  label: Text(
                    "Aparcar",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: buttonsTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  onPressed: () {
                    sendChargeAction(ref.read(authProvider));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonsBackgroundColor, // Background color
                  ),
                ),
                ElevatedButton.icon(
                  icon: Icon(
                    Icons.pause,
                    color: buttonsTextColor,
                  ),
                  label: Text(
                    "Pausar",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: buttonsTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  onPressed: () {
                    sendPauseAction(ref.read(authProvider));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonsBackgroundColor, // Background color
                  ),
                ),
                ElevatedButton.icon(
                  icon: Icon(
                    Icons.play_arrow,
                    color: buttonsTextColor,
                  ),
                  label: Text(
                    "Segar",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: buttonsTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  onPressed: () {
                    sendMowAction(ref.read(authProvider));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonsBackgroundColor, // Background color
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
