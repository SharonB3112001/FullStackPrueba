import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/address.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void addAddress(Address address) {
    _user?.addresses.add(address);
    notifyListeners();
  }
}
