import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nenda_invfest/cubit/auth/auth_cubit.dart';
import 'package:nenda_invfest/cubit/pendakian/pendakian_cubit.dart';
import 'package:nenda_invfest/data/model/article_model.dart';
import 'package:nenda_invfest/data/model/user_model.dart';
import 'package:nenda_invfest/data/static_data.dart';
import 'package:nenda_invfest/presentation/widgets/card_mountain_widget.dart';

import '../../constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndexArticle = 0;
  bool _isLoading = false;

  @override
  void initState() {
    context.read<PendakianCubit>().fetchPendakian();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<PendakianCubit>().fetchPendakian();
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            final UserModel user = state.user;
            return Padding(
              padding: EdgeInsets.only(left: 24, right: 24, top: 32),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Text(
                    'Halo,\n${user.namaLengkap}',
                    style: NendaStyles.fontMedium,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Ayo, rencanakan pendakianmu \nsekarang!',
                    style: NendaStyles.fontParagraph,
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    height: 160,
                    child: PageView.builder(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          _bannerArticle(articleList[index]),
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (val) {
                        _currentIndexArticle = val;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < articleList.length; i++)
                        (i == _currentIndexArticle)
                            ? _artikelDotIndicator(isActive: true)
                            : _artikelDotIndicator()
                    ],
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  _BoxCategories(),
                  SizedBox(
                    height: 48,
                  ),
                  Text(
                    'Pendakian Populer',
                    style: NendaStyles.fontMedium,
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  BlocConsumer<PendakianCubit, PendakianState>(
                    listener: (context, state) {
                      if (state is PendakianError) {
                        _isLoading = false;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(state.errorMessage.toString()),
                          backgroundColor: Colors.black,
                        ));
                      } else if (state is PendakianLoading) {
                        _isLoading = true;
                      }
                    },
                    builder: (context, state) {
                      if (state is PendakianSuccess) {
                        return SizedBox(
                          height: 300,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => CardMountain(
                              data: state.pendakian[index],
                            ),
                            itemCount: state.pendakian.length,
                            scrollDirection: Axis.horizontal,
                          ),
                        );
                      } else {
                        return Container(
                          width: 300,
                          height: 180,
                          child: Center(
                            child: CircularProgressIndicator(
                              backgroundColor: kOrange,
                              color: Colors.deepOrange,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: kLightGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 72),
                ],
              ),
            );
          } else if (state is AuthError) {
            return Center(
              child: Text(state.errorMessage.toString()),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Container _bannerArticle(ArticleModel data) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: 300,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage("${data.backgroundUrl}"),
          fit: BoxFit.fill,
        ),
      ),
      child: Container(
        height: 50,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black54],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "${data.title}",
              style: TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "${data.publishedAt}",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  AnimatedContainer _artikelDotIndicator({bool isActive = false}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: isActive ? 24 : 10,
      height: 10,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: isActive ? kOrange : kOrange.withOpacity(0.5),
      ),
    );
  }
}

class _BoxCategories extends StatelessWidget {
  const _BoxCategories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kategori',
          style: NendaStyles.fontMedium,
        ),
        SizedBox(
          height: 32,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _AppCategories(
              title: "Pendakian",
              iconName: "ic-pendakian",
            ),
            _AppCategories(
              title: "Fasilitas",
              iconName: "ic-fasilitas",
            ),
            _AppCategories(
              title: "Artikel",
              iconName: "ic-book",
            ),
          ],
        )
      ],
    );
  }
}

class _AppCategories extends StatelessWidget {
  final String title;
  final String iconName;

  const _AppCategories({
    Key? key,
    required this.title,
    required this.iconName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [kOrange.withOpacity(0.7), Color(0xFFDF2800)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              image: DecorationImage(
                image: AssetImage('assets/images/$iconName.webp'),
                scale: 4,
              )),
        ),
        SizedBox(height: 16),
        Text(
          "$title",
          style: NendaStyles.fontParagraph,
        )
      ],
    );
  }
}
