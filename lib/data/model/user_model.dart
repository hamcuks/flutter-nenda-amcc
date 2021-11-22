import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  UserModel({
    required this.id,
    required this.namaLengkap,
    required this.email,
    required this.username,
    this.kewarganegaraan = '',
    this.nik = '',
    this.noHandphone = '',
    required this.password,
    this.photo = '',
  });

  String id;
  String namaLengkap;
  String username;
  String email;
  String password;
  String? noHandphone;
  String? kewarganegaraan;
  String? nik;
  String? photo;

  @override
  List<Object?> get props => [
        id,
        namaLengkap,
        email,
        username,
        kewarganegaraan,
        nik,
        noHandphone,
        password,
        photo
      ];
}
