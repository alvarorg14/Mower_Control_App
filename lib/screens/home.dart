import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mower_control_app/providers/auth_provider.dart';
import 'package:mower_control_app/screens/auth.dart';
import 'package:mower_control_app/models/auth.dart';
import 'package:mower_control_app/screens/tabs.dart';
import 'package:mower_control_app/utils/notifications.dart';

const storage = FlutterSecureStorage();

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void getAuthFromLocal(WidgetRef ref) async {
    String? token = await storage.read(key: 'token');
    String? employeeId = await storage.read(key: 'employeeId');
    String? companyId = await storage.read(key: 'companyId');
    String? role = await storage.read(key: 'role');

    if (token != null && employeeId != null && companyId != null && role != null) {
      ref.read(authProvider.notifier).setAuth(
            Auth(
              token: token,
              employeeId: employeeId,
              companyId: companyId,
              role: role,
            ),
          );
    }
  }

  void showNotificationModal(String employeeId) async {
    String? deviceId = await storage.read(key: 'deviceId');

    if (deviceId == null) {
      requestPermission();
      getToken(employeeId);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    getAuthFromLocal(ref);

    final auth = ref.watch(authProvider);

    if (auth.token.isEmpty) {
      return const AuthScreen();
    }

    showNotificationModal(auth.employeeId);

    return const TabsScreen();
  }
}
