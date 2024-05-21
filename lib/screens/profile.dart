import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mower_control_app/providers/auth_provider.dart';
import 'package:mower_control_app/models/auth.dart';

const storage = FlutterSecureStorage();

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  void _logOut() {
    storage.deleteAll();
    ref.read(authProvider.notifier).setAuth(
          const Auth(companyId: '', token: '', employeeId: ''),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: _logOut,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.onBackground,
        ),
        child: Text(
          "Cerrar sesión",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.background,
              ),
        ),
      ),
    );
  }
}
