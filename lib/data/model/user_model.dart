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

  final String id;
  final String namaLengkap;
  final String username;
  final String email;
  final String password;
  final String? noHandphone;
  final String? kewarganegaraan;
  final String? nik;
  final String? photo;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] != null ? json['id'] : '',
        username: json['username'] != null ? json['username'] : '',
        email: json['email'] != null ? json['email'] : '',
        password: json['password'] != null ? json['password'] : '',
        nik: json['nik'] != null ? json['nik'] : '',
        photo: json['photo'] != null ? json['photo'] : '',
        namaLengkap: json['nama_lengkap'] != null ? json['nama_lengkap'] : '',
        noHandphone: json['no_handphone'] != null ? json['no_handphone'] : '',
        kewarganegaraan:
            json['kewarganegaraan'] != null ? json['kewarganegaraan'] : '',
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "nama_lengkap": namaLengkap,
        "nik": nik,
        "kewarganegaraan": kewarganegaraan,
        "no_handphone": noHandphone,
        "photo": photo,
        "password": password,
        "email": email,
      };

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
