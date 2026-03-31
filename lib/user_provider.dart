import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  // Data default atau data yang diisi saat login
  String _username = "";
  String _nik = "1234567890123456"; // Default NIK/NPWP (Bisa disesuaikan)
  String _email = "user@example.com"; 
  String _phone = "08123456789";    

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
  // [MODIFIKASI]: Menambahkan parameter newNik
  void updateProfile(String newNik, String newEmail, String newPhone) {
    _nik = newNik;
    _email = newEmail;
    _phone = newPhone;
    notifyListeners();
  }
}