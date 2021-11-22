import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nenda_invfest/data/model/user_model.dart';

class UserService {
  CollectionReference _userRef = FirebaseFirestore.instance.collection('users');

  Future<void> setUser(UserModel user) async {
    try {
      _userRef.doc(user.id).set({
        'nama_lengkap': user.namaLengkap,
        'email': user.email,
        'username': user.username,
        'password': user.password,
        'no_handphone': user.noHandphone,
        'nik': user.nik,
        'kewarganegaraan': user.kewarganegaraan,
        'photo': user.photo,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<UserModel> getUserById(String id) async {
    try {
      DocumentSnapshot data = await _userRef.doc(id).get();
      return UserModel(
        email: data['email'],
        id: id,
        namaLengkap: data['nama_lengkap'],
        password: data['password'],
        username: data['username'],
      );
    } catch (e) {
      throw e.toString();
    }
  }
}
