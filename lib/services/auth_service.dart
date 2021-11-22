import 'package:firebase_auth/firebase_auth.dart';
import 'package:nenda_invfest/data/model/user_model.dart';
import 'package:nenda_invfest/services/user_service.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel> signIn(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      UserModel user =
          await UserService().getUserById(userCredential.user!.uid);
      return user;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<UserModel> signUp({
    required String email,
    required String username,
    required String password,
    required String namaLengkap,
    String? noHandphone,
    String? nik,
    String? kewarganegaraan,
    String? photo,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel user = UserModel(
        id: userCredential.user!.uid,
        namaLengkap: namaLengkap,
        email: email,
        username: username,
        password: password,
        noHandphone: noHandphone,
        nik: nik,
        kewarganegaraan: kewarganegaraan,
        photo: photo,
      );

      await UserService().setUser(user);
      return user;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> signOut() async {
    try {
      _auth.signOut();
    } catch (e) {
      throw e.toString();
    }
  }
}
