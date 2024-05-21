import 'package:flutter/material.dart';

class RemoteControl extends StatelessWidget {
  const RemoteControl({
    super.key,
    required this.mowerId,
  });

  final String mowerId;

  @override
  Widget build(BuildContext context) {
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
                    // Add your stop action here
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
                    // Add your pause action here
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
                    // Add your resume action here
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
