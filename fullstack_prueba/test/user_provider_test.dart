import 'package:flutter_test/flutter_test.dart';
import '../lib/models/user.dart';
import '../lib/models/address.dart';
import '../lib/providers/user_provider.dart';

void main() {
  group('UserProvider Tests', () {
    late UserProvider userProvider;

    setUp(() {
      userProvider = UserProvider();
    });

    test('Crear usuario correctamente', () {
      final user = User(
        firstName: 'Ana',
        lastName: 'Perez',
        birthDate: DateTime(1990, 1, 1),
      );

      userProvider.setUser(user);

      expect(userProvider.user, isNotNull);
      expect(userProvider.user!.firstName, 'Ana');
      expect(userProvider.user!.lastName, 'Perez');
    });

    test('Agregar dirección al usuario', () {
      final user = User(
        firstName: 'Ana',
        lastName: 'Perez',
        birthDate: DateTime(1990, 1, 1),
      );
      userProvider.setUser(user);

      final address = Address(
        country: 'Colombia',
        department: 'Cundinamarca',
        municipality: 'Bogotá',
      );

      userProvider.addAddress(address);

      expect(userProvider.user!.addresses.length, 1);
      expect(userProvider.user!.addresses.first.municipality, 'Bogotá');
    });

    test('Agregar varias direcciones', () {
      final user = User(
        firstName: 'Juan',
        lastName: 'Lopez',
        birthDate: DateTime(1985, 5, 20),
      );
      userProvider.setUser(user);

      final address1 = Address(
        country: 'Colombia',
        department: 'Antioquia',
        municipality: 'Medellín',
      );

      final address2 = Address(
        country: 'Colombia',
        department: 'Cundinamarca',
        municipality: 'Bogotá',
      );

      userProvider.addAddress(address1);
      userProvider.addAddress(address2);

      expect(userProvider.user!.addresses.length, 2);
      expect(userProvider.user!.addresses[1].municipality, 'Bogotá');
    });
  });
}
