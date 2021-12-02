import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:nenda_invfest/data/model/user_model.dart';
import 'package:path/path.dart';

class UserService {
  CollectionReference _userRef = FirebaseFirestore.instance.collection('users');

  Future<void> setUser(UserModel user) async {
    try {
      _userRef.doc(user.id).set({
        'id': user.id,
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
      print('DBG: ${data.data()}');
      return UserModel.fromJson(data.data() as Map<String, dynamic>);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateUser(UserModel userData) async {
    try {
      await _userRef.doc(userData.id).update(userData.toJson());
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> uploadImageToFirebaseStorage(File file) async {
    try {
      String fileName =
          DateTime.now().toString().split(' ').join() + basename(file.path);
      fs.Reference _ref =
          fs.FirebaseStorage.instance.ref().child('upload/$fileName');
      var _task = await _ref.putFile(file);

      return _task.ref.getDownloadURL();
    } catch (e) {
      throw e;
    }
  }
}
