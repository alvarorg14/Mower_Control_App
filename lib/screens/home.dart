import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mower_control_app/providers/auth_provider.dart';
import 'package:mower_control_app/screens/auth.dart';
import 'package:mower_control_app/screens/mowers.dart';
import 'package:mower_control_app/models/auth.dart';

const storage = FlutterSecureStorage();

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void getAuthFromLocal(WidgetRef ref) async {
    String? token = await storage.read(key: 'token');
    String? employeedId = await storage.read(key: 'employeeId');

    if (token != null && employeedId != null) {
      ref.read(authProvider.notifier).setAuth(
            Auth(
              token: token,
              employeeId: employeedId,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    getAuthFromLocal(ref);

    final auth = ref.watch(authProvider);

    if (auth.token.isEmpty) {
      return const AuthScreen();
    }

    return const MowersScreen();
  }
}
