import 'package:flutter_test/flutter_test.dart';
import 'package:fullstack_prueba/models/user.dart';
import 'package:fullstack_prueba/models/address.dart';


void main() {
  group('Validaciones de formulario', () {
    test('Nombre y apellido no pueden estar vacíos', () {
      String firstName = '';
      String lastName = '';

      bool isValid = firstName.isNotEmpty && lastName.isNotEmpty;

      expect(isValid, false);

      firstName = 'Ana';
      lastName = 'Perez';

      isValid = firstName.isNotEmpty && lastName.isNotEmpty;
      expect(isValid, true);
    });

    test('Fecha de nacimiento no puede ser nula y debe ser pasada', () {
      DateTime? birthDate;

      bool isValid = birthDate != null && birthDate.isBefore(DateTime.now());
      expect(isValid, false);

      birthDate = DateTime(1990, 5, 20);
      isValid = birthDate != null && birthDate.isBefore(DateTime.now());
      expect(isValid, true);
    });

    test('Campos de dirección no pueden estar vacíos', () {
      String country = '';
      String department = '';
      String municipality = '';

      bool isValid = country.isNotEmpty && department.isNotEmpty && municipality.isNotEmpty;
      expect(isValid, false);

      country = 'Colombia';
      department = 'Cundinamarca';
      municipality = 'Bogotá';

      isValid = country.isNotEmpty && department.isNotEmpty && municipality.isNotEmpty;
      expect(isValid, true);
    });

    test('Agregar dirección a usuario valida campos antes', () {
      final user = User(firstName: 'Juan', lastName: 'Lopez', birthDate: DateTime(1985, 1, 1));

      final address = Address(
        country: 'Colombia',
        department: 'Antioquia',
        municipality: 'Medellín',
      );

      // Simulando validación antes de agregar
      bool isValid = address.country.isNotEmpty &&
          address.department.isNotEmpty &&
          address.municipality.isNotEmpty;

      if (isValid) {
        user.addresses.add(address);
      }

      expect(user.addresses.length, 1);
      expect(user.addresses.first.municipality, 'Medellín');
    });
  });
}
