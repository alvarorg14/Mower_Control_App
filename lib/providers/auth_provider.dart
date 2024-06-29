import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mower_control_app/models/auth.dart';

class AuthProvider extends StateNotifier<Auth> {
  AuthProvider() : super(const Auth(token: '', employeeId: '', companyId: '', role: ''));

  void setAuth(Auth auth) {
    state = auth;
  }
}

final authProvider = StateNotifierProvider<AuthProvider, Auth>(
  (ref) => AuthProvider(),
);
