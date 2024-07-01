import 'package:flutter/material.dart';

class SignupInputs {
  const SignupInputs();

  List<Widget> getSignupInputs(
    BuildContext context,
    Function setCompanyName,
    Function setCif,
    Function setName,
    Function setSurname1,
    Function setSurname2,
    Function setUsername,
    Function setPassword,
  ) {
    return [
      TextFormField(
        decoration: const InputDecoration(
          labelText: 'Nombre de la empresa',
        ),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Introduzca un nombre válido';
          }
          if (value.trim().length < 3 || value.trim().length > 50) {
            return 'El nombre tiene que tener entre 3 y 50 caracteres';
          }
          return null;
        },
        onSaved: (value) {
          setCompanyName(value!);
        },
      ),
      TextFormField(
        decoration: const InputDecoration(
          labelText: 'CIF',
        ),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Introduzca un CIF válido';
          }
          if (value.trim().length != 9) {
            return 'CIF tiene que tener 9 caracteres';
          }
          return null;
        },
        onSaved: (value) {
          setCif(value!);
        },
      ),
      TextFormField(
        decoration: const InputDecoration(
          labelText: 'Nombre',
        ),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Introduzca un nombre válido';
          }
          if (value.trim().length < 3 || value.trim().length > 50) {
            return 'El nombre tiene que tener entre 3 y 50 caracteres';
          }
          return null;
        },
        onSaved: (value) {
          setName(value!);
        },
      ),
      TextFormField(
        decoration: const InputDecoration(
          labelText: 'Primer apellido',
        ),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Introduzca un appellido válido';
          }
          if (value.trim().length < 3 || value.trim().length > 50) {
            return 'El apellido tiene que tener entre 3 y 50 caracteres';
          }
          return null;
        },
        onSaved: (value) {
          setSurname1(value!);
        },
      ),
      TextFormField(
        decoration: const InputDecoration(
          labelText: 'Segundo apellido (opcional)',
        ),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        validator: (value) {
          if (value != null && (value.trim().length < 3 || value.trim().length > 50)) {
            return 'El apellido tiene que tener entre 3 y 50 caracters';
          }
          return null;
        },
        onSaved: (value) {
          setSurname2(value!);
        },
      ),
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
          if (value.trim().length < 3 || value.trim().length > 20) {
            return 'El usuario tiene que tener entre 3 y 20 caracteres';
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
          if (value.trim().length < 8 || value.trim().length > 20) {
            return 'La contraseña tiene que tener entre 8 y 20 caracteres';
          }
          return null;
        },
        onSaved: (value) {
          setPassword(value!);
        },
      ),
    ];
  }
}
