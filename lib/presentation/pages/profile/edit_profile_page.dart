import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nenda_invfest/constant.dart';
import 'package:nenda_invfest/cubit/navigation/navigation_cubit.dart';
import 'package:nenda_invfest/cubit/user/user_cubit.dart';
import 'package:nenda_invfest/data/model/user_model.dart';
import 'package:nenda_invfest/presentation/widgets/app_button_widget.dart';
import 'package:nenda_invfest/presentation/widgets/app_input_widget.dart';

class EditProfilePage extends StatefulWidget {
  final UserModel data;
  EditProfilePage({Key? key, required this.data}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  final TextEditingController _kewarganegaraanController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;
  XFile? ubahFoto;
  File? file;

  Future<void> choosePhoto() async {
    var choosedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      ubahFoto = choosedImage;
      file = File(ubahFoto!.path);
    });
    print(file!.path.toString());
  }

  @override
  void initState() {
    _namaController.text = widget.data.namaLengkap;
    _usernameController.text = widget.data.username;
    _noHpController.text = widget.data.noHandphone!;
    _nikController.text = widget.data.nik!;
    _kewarganegaraanController.text = widget.data.kewarganegaraan!;

    super.initState();
  }

  @override
  void dispose() {
    _namaController.dispose();
    _usernameController.dispose();
    _noHpController.dispose();
    _nikController.dispose();
    _kewarganegaraanController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Edit Profile',
                    style: NendaStyles.fontMedium,
                  ),
                ],
              ),
              SizedBox(height: 32),
              Container(
                height: 100,
                width: 100,
                child: Stack(
                  children: [
                    Container(
                      width: 94,
                      height: 94,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: file != null
                              ? FileImage(file!)
                              : widget.data.photo != null
                                  ? CachedNetworkImageProvider(
                                      widget.data.photo!)
                                  : CachedNetworkImageProvider(
                                      'https://firebasestorage.googleapis.com/v0/b/nenda-invfest.appspot.com/o/images%2F136-1366211_group-of-10-guys-login-user-icon-png.png?alt=media&token=a39821a6-7da2-4af8-b8a0-6be72e884037',
                                    ) as ImageProvider,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () => choosePhoto(),
                        icon: Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kOrange,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              AppInput(
                label: 'Nama Lengkap',
                hintText: 'Masukkan Nama Lengkap',
                controller: _namaController,
                initialValue: widget.data.namaLengkap,
              ),
              SizedBox(height: 16),
              AppInput(
                label: 'Username',
                hintText: 'Masukkan Username',
                controller: _usernameController,
                initialValue: widget.data.username,
              ),
              SizedBox(height: 16),
              AppInput(
                label: 'No Handphone',
                hintText: 'Masukkan No Handphone',
                controller: _noHpController,
                initialValue: widget.data.username,
              ),
              SizedBox(height: 16),
              AppInput(
                label: 'NIK',
                hintText: 'Masukkan NIK',
                controller: _nikController,
                initialValue: widget.data.nik,
              ),
              SizedBox(height: 16),
              AppInput(
                  label: 'Kewarganegaraan',
                  hintText: 'Masukkan Kewarganegaraan',
                  controller: _kewarganegaraanController,
                  initialValue: widget.data.kewarganegaraan),
              SizedBox(height: 62),
              BlocConsumer<UserCubit, UserState>(
                listener: (context, state) async {
                  if (state is UserLoading) {
                    _isLoading = true;
                  } else if (state is UserSuccess) {
                    _isLoading = false;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Data berhasil diperbaharui'),
                      backgroundColor: Colors.black,
                    ));

                    Future.delayed(Duration(milliseconds: 500), () {
                      context
                          .read<NavigationCubit>()
                          .setNavigation(Navigation.SETTINGS);
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/main', (route) => false);
                    });
                  } else if (state is UserError) {
                    print(state.error);
                    _isLoading = false;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.error.toString()),
                      backgroundColor: Colors.black,
                    ));
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    isLoading: _isLoading,
                    width: double.infinity,
                    height: 52,
                    text: 'Perbaharui',
                    onPressed: () {
                      UserModel user = UserModel(
                        email: widget.data.email,
                        namaLengkap: _namaController.text,
                        id: widget.data.id,
                        password: widget.data.password,
                        username: _usernameController.text,
                        noHandphone: _noHpController.text,
                        nik: _nikController.text,
                        kewarganegaraan: _kewarganegaraanController.text,
                        photo: widget.data.photo,
                      );
                      print('DBG: ${widget.data.id}');
                      context
                          .read<UserCubit>()
                          .updateUser(userData: user, file: file);
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
