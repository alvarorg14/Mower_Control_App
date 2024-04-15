import 'package:flutter/material.dart';

class LoginInputs {
  const LoginInputs();

  List<Widget> getLoginInputs(BuildContext context, Function setUsername, Function setPassword) {
    return [
      TextFormField(
        decoration: const InputDecoration(
          labelText: 'Username',
        ),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter a valid username';
          }
          return null;
        },
        onSaved: (value) {
          setUsername(value!);
        },
      ),
      TextFormField(
        decoration: const InputDecoration(
          labelText: 'Password',
        ),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        obscureText: true,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter a valid password';
          }
          return null;
        },
        onSaved: (value) {
          setPassword(value!);
        },
      )
    ];
  }
}
