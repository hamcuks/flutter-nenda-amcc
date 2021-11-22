import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nenda_invfest/data/model/user_model.dart';
import 'package:nenda_invfest/services/auth_service.dart';
import 'package:nenda_invfest/services/user_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signIn({required String email, required String password}) async {
    try {
      emit(AuthLoading());
      UserModel user =
          await AuthService().signIn(email: email, password: password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void signup({
    required String email,
    required String username,
    required String password,
    required String namaLengkap,
  }) async {
    try {
      emit(AuthLoading());
      UserModel user = await AuthService().signUp(
          email: email,
          username: username,
          password: password,
          namaLengkap: namaLengkap);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void signOut() async {
    try {
      emit(AuthLoading());
      await AuthService().signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void getCurrentUser(String id) async {
    try {
      emit(AuthLoading());
      UserModel user = await UserService().getUserById(id);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
