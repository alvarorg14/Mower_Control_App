import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mower_control_app/api/auth.dart';
import 'package:mower_control_app/utils/login_inputs.dart';
import 'package:mower_control_app/utils/signup_inputs.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_links/uni_links.dart';

const storage = FlutterSecureStorage();
const loginApi = AuthApi();
const loginInputs = LoginInputs();
const signupInputs = SignupInputs();

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _form = GlobalKey<FormState>();

  var _isLogin = true;
  var _enteredCompanyName = '';
  var _enteredCif = '';
  var _enteredName = '';
  var _enteredSurname1 = '';
  var _enteredSurname2 = '';
  var _enteredUsername = '';
  var _enteredPassword = '';
  var _authCode = '';
  var _state = '';

  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    initUniLinks();
  }

  Future<void> initUniLinks() async {
    // Deep links handling
    getInitialUri().then((Uri? uri) {
      if (uri != null) {
        _handleDeepLink(uri);
      }
    });

    // Listen for incoming links (after the app is already opened)
    uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleDeepLink(uri);
      }
    }, onError: (err) {
      print(err);
    });
  }

  void _handleDeepLink(Uri uri) {
    String? authCode = uri.queryParameters['code'];
    String? state = uri.queryParameters['state'];

    if (authCode != null && state != null) {
      _authCode = authCode;
      _state = state;
      _signup();
    }
  }

  void _submit() async {
    if (_isLogin) {
      final isValid = _form.currentState!.validate();

      if (!isValid) {
        return;
      }

      _form.currentState!.save();

      loginApi.login(ref, _enteredUsername, _enteredPassword);
    } else {
      final isValid = _form.currentState!.validate();

      if (!isValid) {
        return;
      }

      _form.currentState!.save();

      Uri url = Uri.https('api.authentication.husqvarnagroup.dev', '/v1/oauth2/authorize', {
        'client_id': '4be569c1-f472-4e57-8557-d25f237ce8ab',
        'redirect_uri': 'com.mowercontrol.app://auth',
      });
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        print('Could not launch $url');
      }
    }
  }

  void _signup() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await loginApi.signup(
        ref,
        _enteredCompanyName,
        _enteredCif,
        _enteredName,
        _enteredSurname1,
        _enteredSurname2,
        _enteredUsername,
        _enteredPassword,
        _authCode,
        _state,
      );
    } catch (error) {
      setState(() {
        _isLoading = false;
      });

      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _setCif(String cif) {
    _enteredCif = cif;
  }

  void _setCompanyName(String companyName) {
    _enteredCompanyName = companyName;
  }

  void _setName(String name) {
    _enteredName = name;
  }

  void _setSurname1(String surname1) {
    _enteredSurname1 = surname1;
  }

  void _setSurname2(String surname2) {
    _enteredSurname2 = surname2;
  }

  void _setUsername(String username) {
    _enteredUsername = username;
  }

  void _setPassword(String password) {
    _enteredPassword = password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.85),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 30,
                    bottom: 40,
                    left: 20,
                    right: 20,
                  ),
                  width: 250,
                  child: Image.asset('assets/images/logo.png'), // Updated line
                ),
                Card(
                  margin: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ..._isLogin
                              ? loginInputs.getLoginInputs(context, _setUsername, _setPassword)
                              : signupInputs.getSignupInputs(context, _setCompanyName, _setCif, _setName, _setSurname1,
                                  _setSurname2, _setUsername, _setPassword),
                          const SizedBox(
                            height: 12,
                          ),
                          ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                            ),
                            child: Text(_isLogin ? 'Login' : 'Signup'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(
                              _isLogin ? 'Create an account' : 'I already have an account',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
