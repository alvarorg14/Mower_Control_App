import 'package:flutter/material.dart';

class LoginInputs {
  const LoginInputs();

  List<Widget> getLoginInputs(BuildContext context, Function setUsername, Function setPassword) {
    return [
      TextFormField(
        decoration: const InputDecoration(
          labelText: 'Usuario',
        ),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Introduzca un usuario válido';
          }
          return null;
        },
        onSaved: (value) {
          setUsername(value!);
        },
      ),
      TextFormField(
        decoration: const InputDecoration(
          labelText: 'Contraseña',
        ),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        obscureText: true,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Introduzca una contraseña válida';
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
