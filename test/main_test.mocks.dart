// Mocks generated by Mockito 5.4.5 from annotations
// in compostapp/test/main_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;
import 'dart:ui' as _i8;

import 'package:compostapp/compost_state.dart' as _i6;
import 'package:compostapp/models/availability_model.dart' as _i7;
import 'package:compostapp/models/compost_component_model.dart' as _i5;
import 'package:compostapp/models/recipe_model.dart' as _i4;
import 'package:compostapp/services/persistence_manager.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakePersistenceManager_0 extends _i1.SmartFake
    implements _i2.PersistenceManager {
  _FakePersistenceManager_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [PersistenceManager].
///
/// See the documentation for Mockito's code generation for more information.
class MockPersistenceManager extends _i1.Mock
    implements _i2.PersistenceManager {
  MockPersistenceManager() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool> saveRecipe(_i4.Recipe? recipe) =>
      (super.noSuchMethod(
            Invocation.method(#saveRecipe, [recipe]),
            returnValue: _i3.Future<bool>.value(false),
          )
          as _i3.Future<bool>);

  @override
  _i3.Future<_i4.Recipe?> getLatestRecipe() =>
      (super.noSuchMethod(
            Invocation.method(#getLatestRecipe, []),
            returnValue: _i3.Future<_i4.Recipe?>.value(),
          )
          as _i3.Future<_i4.Recipe?>);

  @override
  _i3.Future<List<_i4.Recipe>> getRecipeHistory() =>
      (super.noSuchMethod(
            Invocation.method(#getRecipeHistory, []),
            returnValue: _i3.Future<List<_i4.Recipe>>.value(<_i4.Recipe>[]),
          )
          as _i3.Future<List<_i4.Recipe>>);

  @override
  _i3.Future<bool> updateComponentInfo(
    List<_i5.CompostComponent>? components,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#updateComponentInfo, [components]),
            returnValue: _i3.Future<bool>.value(false),
          )
          as _i3.Future<bool>);

  @override
  _i3.Future<List<_i5.CompostComponent>?> getSavedComponents() =>
      (super.noSuchMethod(
            Invocation.method(#getSavedComponents, []),
            returnValue: _i3.Future<List<_i5.CompostComponent>?>.value(),
          )
          as _i3.Future<List<_i5.CompostComponent>?>);

  @override
  _i3.Future<bool> clearCurrentRecipe() =>
      (super.noSuchMethod(
            Invocation.method(#clearCurrentRecipe, []),
            returnValue: _i3.Future<bool>.value(false),
          )
          as _i3.Future<bool>);

  @override
  _i3.Future<bool> clearRecipeHistory() =>
      (super.noSuchMethod(
            Invocation.method(#clearRecipeHistory, []),
            returnValue: _i3.Future<bool>.value(false),
          )
          as _i3.Future<bool>);

  @override
  _i3.Future<bool> clearComponentData() =>
      (super.noSuchMethod(
            Invocation.method(#clearComponentData, []),
            returnValue: _i3.Future<bool>.value(false),
          )
          as _i3.Future<bool>);

  @override
  _i3.Future<bool> clearAll() =>
      (super.noSuchMethod(
            Invocation.method(#clearAll, []),
            returnValue: _i3.Future<bool>.value(false),
          )
          as _i3.Future<bool>);
}

/// A class which mocks [CompostState].
///
/// See the documentation for Mockito's code generation for more information.
class MockCompostState extends _i1.Mock implements _i6.CompostState {
  MockCompostState() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.PersistenceManager get persistenceManager =>
      (super.noSuchMethod(
            Invocation.getter(#persistenceManager),
            returnValue: _FakePersistenceManager_0(
              this,
              Invocation.getter(#persistenceManager),
            ),
          )
          as _i2.PersistenceManager);

  @override
  List<_i5.CompostComponent> get components =>
      (super.noSuchMethod(
            Invocation.getter(#components),
            returnValue: <_i5.CompostComponent>[],
          )
          as List<_i5.CompostComponent>);

  @override
  set components(List<_i5.CompostComponent>? _components) => super.noSuchMethod(
    Invocation.setter(#components, _components),
    returnValueForMissingStub: null,
  );

  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);

  @override
  void updateComponent(_i5.CompostComponent? updatedComponent) =>
      super.noSuchMethod(
        Invocation.method(#updateComponent, [updatedComponent]),
        returnValueForMissingStub: null,
      );

  @override
  List<_i5.CompostComponent> getAvailableComponents(DateTime? date) =>
      (super.noSuchMethod(
            Invocation.method(#getAvailableComponents, [date]),
            returnValue: <_i5.CompostComponent>[],
          )
          as List<_i5.CompostComponent>);

  @override
  void updateComponentPrice(String? componentName, double? newPrice) =>
      super.noSuchMethod(
        Invocation.method(#updateComponentPrice, [componentName, newPrice]),
        returnValueForMissingStub: null,
      );

  @override
  void updateComponentAvailability(
    String? componentId,
    _i7.AvailabilityPeriod? newAvailability,
  ) => super.noSuchMethod(
    Invocation.method(#updateComponentAvailability, [
      componentId,
      newAvailability,
    ]),
    returnValueForMissingStub: null,
  );

  @override
  void addListener(_i8.VoidCallback? listener) => super.noSuchMethod(
    Invocation.method(#addListener, [listener]),
    returnValueForMissingStub: null,
  );

  @override
  void removeListener(_i8.VoidCallback? listener) => super.noSuchMethod(
    Invocation.method(#removeListener, [listener]),
    returnValueForMissingStub: null,
  );

  @override
  void dispose() => super.noSuchMethod(
    Invocation.method(#dispose, []),
    returnValueForMissingStub: null,
  );

  @override
  void notifyListeners() => super.noSuchMethod(
    Invocation.method(#notifyListeners, []),
    returnValueForMissingStub: null,
  );
}
