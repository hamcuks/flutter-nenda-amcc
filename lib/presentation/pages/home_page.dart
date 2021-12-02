import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nenda_invfest/cubit/article/article_cubit.dart';
import 'package:nenda_invfest/cubit/auth/auth_cubit.dart';
import 'package:nenda_invfest/cubit/pendakian/pendakian_cubit.dart';
import 'package:nenda_invfest/data/model/article_model.dart';
import 'package:nenda_invfest/data/model/pendakian_model.dart';
import 'package:nenda_invfest/data/model/user_model.dart';
import 'package:nenda_invfest/presentation/pages/artikel/detail_artikel_page.dart';
import 'package:nenda_invfest/presentation/widgets/card_mountain_widget.dart';
import 'package:nenda_invfest/presentation/widgets/content_loading_widgets.dart';

import '../../constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _popuplarArticlesController =
      PageController(initialPage: 0, keepPage: true);
  int _currentIndexArticle = 0;

  @override
  void initState() {
    print('init');
    _currentIndexArticle = 0;
    context.read<PendakianCubit>().fetchPendakian();
    context.read<ArticleCubit>().fetchArticles();
    super.initState();
  }

  @override
  void dispose() {
    _popuplarArticlesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ArticleCubit>().fetchArticles();
        context.read<PendakianCubit>().fetchPendakian();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 32),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthSuccess) {
                  final UserModel user = state.user;
                  bool isPhotoNotAvailable = [null, ''].contains(user.photo);
                  return Row(
                    children: [
                      Text(
                        'Halo,\n${user.namaLengkap}',
                        style: NendaStyles.fontMedium,
                      ),
                      Spacer(),
                      Container(
                        width: 72,
                        height: 72,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              !isPhotoNotAvailable
                                  ? user.photo!
                                  : 'https://firebasestorage.googleapis.com/v0/b/nenda-invfest.appspot.com/o/images%2F136-1366211_group-of-10-guys-login-user-icon-png.png?alt=media&token=a39821a6-7da2-4af8-b8a0-6be72e884037',
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Row(
                  children: [
                    Text(
                      'Halo,\nPendaki',
                      style: NendaStyles.fontMedium,
                    ),
                    Spacer(),
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            'https://firebasestorage.googleapis.com/v0/b/nenda-invfest.appspot.com/o/images%2F136-1366211_group-of-10-guys-login-user-icon-png.png?alt=media&token=a39821a6-7da2-4af8-b8a0-6be72e884037',
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
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
            BlocConsumer<ArticleCubit, ArticleState>(
              listener: (context, state) {
                if (state is ArticleLoading) {
                } else if (state is ArticleError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.errorMessage.toString()),
                    backgroundColor: Colors.black,
                  ));
                }
              },
              builder: (context, state) {
                if (state is ArticleSuccess) {
                  List<ArticleModel> _popular = state.articles!
                      .where((element) => element.viewCount! >= 500)
                      .toList();
                  return Column(
                    children: [
                      SizedBox(
                        height: 160,
                        child: PageView.builder(
                          controller: _popuplarArticlesController,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) =>
                              _bannerArticle(_popular[index]),
                          itemCount: _popular.length,
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
                          for (int i = 0; i < _popular.length; i++)
                            (i == _currentIndexArticle)
                                ? _artikelDotIndicator(isActive: true)
                                : _artikelDotIndicator()
                        ],
                      ),
                    ],
                  );
                } else {
                  return Container(
                    width: 300,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ContentLoadingWidget(),
                  );
                }
              },
            ),
            SizedBox(
              height: 24,
            ),
            _BoxCategories(),
            SizedBox(
              height: 32,
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
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.errorMessage.toString()),
                    backgroundColor: Colors.black,
                  ));
                }
              },
              builder: (context, state) {
                if (state is PendakianSuccess) {
                  List<PendakianModel> _popular = state.pendakian!
                      .where((element) => element.rating! >= 4.5)
                      .toList();
                  return SizedBox(
                    height: 300,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => CardMountain(
                        data: _popular[index],
                      ),
                      itemCount: _popular.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  );
                } else {
                  return Container(
                    width: 300,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ContentLoadingWidget(),
                  );
                }
              },
            ),
            SizedBox(height: 72),
          ],
        ),
      ),
    );
  }

  Widget _bannerArticle(ArticleModel data) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailArtikelPage(data: data),
        ),
      ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: double.infinity,
        margin: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: CachedNetworkImageProvider("${data.imagePath}"),
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
              SizedBox(height: 8),
              Text(
                "${data.publishedAt}",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
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
              onTap: () => Navigator.pushNamed(context, '/daftar-pendakian'),
            ),
            _AppCategories(
              title: "Fasilitas",
              iconName: "ic-fasilitas",
              onTap: () => Navigator.pushNamed(context, '/fasilitas'),
            ),
            _AppCategories(
              title: "Artikel",
              iconName: "ic-book",
              onTap: () => Navigator.pushNamed(context, '/daftar-artikel'),
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
  final Function()? onTap;

  const _AppCategories({
    Key? key,
    required this.title,
    required this.iconName,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
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
