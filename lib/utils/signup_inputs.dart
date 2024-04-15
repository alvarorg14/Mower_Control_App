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
          labelText: 'Company Name',
        ),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter a valid company name';
          }
          if (value.trim().length < 3 || value.trim().length > 50) {
            return 'Company name must be between 3 and 50 characters long';
          }
          return null;
        },
        onSaved: (value) {
          setCompanyName(value!);
        },
      ),
      TextFormField(
        decoration: const InputDecoration(
          labelText: 'Company CIF',
        ),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter a valid CIF';
          }
          if (value.trim().length != 9) {
            return 'CIF must be 9 characters long';
          }
          return null;
        },
        onSaved: (value) {
          setCif(value!);
        },
      ),
      TextFormField(
        decoration: const InputDecoration(
          labelText: 'Name',
        ),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter a valid name';
          }
          if (value.trim().length < 3 || value.trim().length > 50) {
            return 'Name must be between 3 and 50 characters long';
          }
          return null;
        },
        onSaved: (value) {
          setName(value!);
        },
      ),
      TextFormField(
        decoration: const InputDecoration(
          labelText: 'Surname 1',
        ),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter a valid surname';
          }
          if (value.trim().length < 3 || value.trim().length > 50) {
            return 'Surname must be between 3 and 50 characters long';
          }
          return null;
        },
        onSaved: (value) {
          setSurname1(value!);
        },
      ),
      TextFormField(
        decoration: const InputDecoration(
          labelText: 'Surname 2 (optional)',
        ),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        validator: (value) {
          if (value != null && (value.trim().length < 3 || value.trim().length > 50)) {
            return 'Surname must be between 3 and 50 characters long';
          }
          return null;
        },
        onSaved: (value) {
          setSurname2(value!);
        },
      ),
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
          if (value.trim().length < 3 || value.trim().length > 20) {
            return 'Username must be between 3 and 20 characters long';
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
          if (value.trim().length < 8 || value.trim().length > 20) {
            return 'Password must be between 8 and 20 characters long';
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
