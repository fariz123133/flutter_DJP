import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  // Data default atau data yang diisi saat login
  String _username = "";
  String _nik = "";
  String _email = "user@example.com"; // Default
  String _phone = "08123456789";    // Default

  // Getter
  String get username => _username;
  String get nik => _nik;
  String get email => _email;
  String get phone => _phone;

  // Fungsi untuk update data saat login
  void login(String user, String nikNpwp) {
    _username = user;
    _nik = nikNpwp;
    notifyListeners(); // Memberitahu semua halaman bahwa data berubah
  }

  // Fungsi untuk update data dari profil (Edit)
  void updateProfile(String newEmail, String newPhone) {
    _email = newEmail;
    _phone = newPhone;
    notifyListeners();
  }
}