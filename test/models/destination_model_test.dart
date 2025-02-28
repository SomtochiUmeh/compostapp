import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:compostapp/models/destination_model.dart';

void main() {
  group('Destination', () {
    test('constructor initializes properties correctly', () {
      const label = 'Test Destination';
      const icon = Icons.home;

      // Define a simple builder function
      Widget builder(BuildContext context) {
        return const Text('Test Widget');
      }

      final destination = Destination(
        label: label,
        icon: icon,
        builder: builder,
      );

      expect(destination.label, equals(label));
      expect(destination.icon, equals(icon));
      expect(destination.builder, equals(builder));
    });

    test('can be used with different IconData', () {
      const iconValues = [
        Icons.home,
        Icons.settings,
        Icons.person,
        Icons.email,
        Icons.favorite,
      ];

      for (final icon in iconValues) {
        final destination = Destination(
          label: 'Test',
          icon: icon,
          builder: (_) => const SizedBox(),
        );

        expect(destination.icon, equals(icon));
      }
    });

    test('can be used with empty label', () {
      final destination = Destination(
        label: '',
        icon: Icons.home,
        builder: (_) => const SizedBox(),
      );

      expect(destination.label, equals(''));
    });

    test('can be stored in a list', () {
      final destinations = [
        Destination(
          label: 'Home',
          icon: Icons.home,
          builder: (_) => const Text('Home Page'),
        ),
        Destination(
          label: 'Settings',
          icon: Icons.settings,
          builder: (_) => const Text('Settings Page'),
        ),
      ];

      expect(destinations.length, equals(2));
      expect(destinations[0].label, equals('Home'));
      expect(destinations[1].label, equals('Settings'));
    });
  });
}
