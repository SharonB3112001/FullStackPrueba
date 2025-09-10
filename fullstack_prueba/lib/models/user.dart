import 'address.dart';

class User {
  String firstName;
  String lastName;
  DateTime birthDate;
  List<Address> addresses;

  User({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    List<Address>? addresses,
  }) : addresses = addresses ?? [];
}
