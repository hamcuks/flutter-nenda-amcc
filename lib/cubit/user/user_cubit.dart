import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nenda_invfest/data/model/user_model.dart';
import 'package:nenda_invfest/services/user_service.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void updateUser({required UserModel userData, File? file}) async {
    try {
      emit(UserLoading());
      String urlImage = '';
      if (file != null)
        urlImage = await UserService().uploadImageToFirebaseStorage(file);
      UserModel user = UserModel(
          id: userData.id,
          email: userData.email,
          password: userData.password,
          namaLengkap: userData.namaLengkap,
          username: userData.username,
          photo: urlImage.isNotEmpty ? urlImage : userData.photo,
          noHandphone: userData.noHandphone,
          nik: userData.nik,
          kewarganegaraan: userData.kewarganegaraan);
      await UserService().updateUser(user);
      emit(UserSuccess());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
