import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nenda_invfest/cubit/auth/auth_cubit.dart';
import 'package:nenda_invfest/cubit/navigation/navigation_cubit.dart';
import 'package:nenda_invfest/data/model/user_model.dart';
import 'package:nenda_invfest/presentation/pages/profile/edit_profile_page.dart';
import 'package:nenda_invfest/presentation/widgets/app_button_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nenda_invfest/presentation/widgets/content_loading_widgets.dart';

import '../../../constant.dart';

class UserSettingsPage extends StatefulWidget {
  UserSettingsPage({Key? key}) : super(key: key);

  @override
  State<UserSettingsPage> createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  User? user;

  @override
  void initState() {
    context.read<AuthCubit>().checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(bottom: 84, top: 24, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profil',
              style: NendaStyles.fontMedium,
            ),
            SizedBox(height: 16),
            Expanded(
              child: Center(
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSignOut) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/onboarding', (route) => false);
                      context
                          .read<NavigationCubit>()
                          .setNavigation(Navigation.HOME);
                    } else if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.errorMessage.toString()),
                        backgroundColor: Colors.black,
                      ));
                    } else if (state is AuthLoading) {
                    } else if (state is AuthInitial) {
                      print('initial');
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', (route) => false);
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthSuccess) {
                      return _buildContent(state.user);
                    } else if (state is AuthLoading) {
                      return ContentLoadingWidget();
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Silahkan login terlebih dahulu untuk melihat profile',
                            style: NendaStyles.fontMedium,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16),
                          AppButton(
                            width: 145,
                            height: 52,
                            text: 'Login',
                            onPressed: () =>
                                Navigator.pushNamed(context, '/login'),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(UserModel data) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    data.photo != ''
                        ? data.photo!
                        : 'https://firebasestorage.googleapis.com/v0/b/nenda-invfest.appspot.com/o/images%2F136-1366211_group-of-10-guys-login-user-icon-png.png?alt=media&token=a39821a6-7da2-4af8-b8a0-6be72e884037',
                  ),
                ),
              ),
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${data.namaLengkap}',
                  style: NendaStyles.fontMedium,
                ),
                SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(data: data),
                    ),
                  ),
                  child: Text(
                    'Edit Profil',
                    style: NendaStyles.fontParagraph,
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 32,
        ),
        _profileData(label: 'Username', data: data.username),
        _profileData(label: 'Email', data: data.email),
        _profileData(label: 'NIK', data: data.nik!),
        _profileData(label: 'Kewarganegaraan', data: data.kewarganegaraan!),
        _profileData(label: 'No Handphone', data: data.noHandphone!),
        Spacer(),
        AppButton(
          width: double.infinity,
          height: 52,
          text: 'Keluar',
          onPressed: () {
            context.read<AuthCubit>().signOut();
          },
        )
      ],
    );
  }

  Widget _profileData({required String label, required String data}) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '$label',
              style: NendaStyles.fontParagraph,
            ),
            Spacer(),
            Text(
              data.isNotEmpty ? data : 'Belum diisi',
              style: NendaStyles.fontParagraph
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
