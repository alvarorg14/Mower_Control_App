// Mocks generated by Mockito 5.4.4 from annotations
// in mower_control_app/test/widgets/client_card_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:mower_control_app/api/clients.dart' as _i7;
import 'package:mower_control_app/api/mowers.dart' as _i4;
import 'package:mower_control_app/models/auth.dart' as _i6;
import 'package:mower_control_app/models/client.dart' as _i3;
import 'package:mower_control_app/models/mower.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeMower_0 extends _i1.SmartFake implements _i2.Mower {
  _FakeMower_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeClient_1 extends _i1.SmartFake implements _i3.Client {
  _FakeClient_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MowersApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockMowersApi extends _i1.Mock implements _i4.MowersApi {
  MockMowersApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<List<_i2.Mower>> fecthMowersForCompany(
    _i6.Auth? auth,
    bool? assigned,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #fecthMowersForCompany,
          [
            auth,
            assigned,
          ],
        ),
        returnValue: _i5.Future<List<_i2.Mower>>.value(<_i2.Mower>[]),
      ) as _i5.Future<List<_i2.Mower>>);

  @override
  _i5.Future<_i2.Mower> assignMowerToClientAndEmployee(
    _i6.Auth? auth,
    String? mowerId,
    String? clientId,
    String? employeeId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #assignMowerToClientAndEmployee,
          [
            auth,
            mowerId,
            clientId,
            employeeId,
          ],
        ),
        returnValue: _i5.Future<_i2.Mower>.value(_FakeMower_0(
          this,
          Invocation.method(
            #assignMowerToClientAndEmployee,
            [
              auth,
              mowerId,
              clientId,
              employeeId,
            ],
          ),
        )),
      ) as _i5.Future<_i2.Mower>);

  @override
  _i5.Future<List<_i2.Mower>> fetchMowersForClient(
    _i6.Auth? auth,
    String? clientId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchMowersForClient,
          [
            auth,
            clientId,
          ],
        ),
        returnValue: _i5.Future<List<_i2.Mower>>.value(<_i2.Mower>[]),
      ) as _i5.Future<List<_i2.Mower>>);

  @override
  _i5.Future<List<_i2.Mower>> fecthMowersForEmployee(
    _i6.Auth? auth,
    String? employeeId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #fecthMowersForEmployee,
          [
            auth,
            employeeId,
          ],
        ),
        returnValue: _i5.Future<List<_i2.Mower>>.value(<_i2.Mower>[]),
      ) as _i5.Future<List<_i2.Mower>>);

  @override
  _i5.Future<void> updateRobotsForCompany(_i6.Auth? auth) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateRobotsForCompany,
          [auth],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}

/// A class which mocks [ClientsApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockClientsApi extends _i1.Mock implements _i7.ClientsApi {
  MockClientsApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<List<_i3.Client>> fetchClientsForCompany(_i6.Auth? auth) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchClientsForCompany,
          [auth],
        ),
        returnValue: _i5.Future<List<_i3.Client>>.value(<_i3.Client>[]),
      ) as _i5.Future<List<_i3.Client>>);

  @override
  _i5.Future<_i3.Client> createClient(
    _i6.Auth? auth,
    String? name,
    String? address,
    int? phoneNumber,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #createClient,
          [
            auth,
            name,
            address,
            phoneNumber,
          ],
        ),
        returnValue: _i5.Future<_i3.Client>.value(_FakeClient_1(
          this,
          Invocation.method(
            #createClient,
            [
              auth,
              name,
              address,
              phoneNumber,
            ],
          ),
        )),
      ) as _i5.Future<_i3.Client>);

  @override
  _i5.Future<void> deleteClient(
    _i6.Auth? auth,
    String? clientId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteClient,
          [
            auth,
            clientId,
          ],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}
