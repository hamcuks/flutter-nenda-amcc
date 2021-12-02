import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nenda_invfest/constant.dart';
import 'package:nenda_invfest/cubit/article/article_cubit.dart';
import 'package:nenda_invfest/presentation/widgets/app_search_bar_widget.dart';
import 'package:nenda_invfest/presentation/widgets/card_artikel_widget.dart';
import 'package:nenda_invfest/presentation/widgets/content_loading_widgets.dart';

class DaftarArtikelPage extends StatefulWidget {
  const DaftarArtikelPage({Key? key}) : super(key: key);

  @override
  State<DaftarArtikelPage> createState() => _DaftarArtikelPageState();
}

class _DaftarArtikelPageState extends State<DaftarArtikelPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    context.read<ArticleCubit>().fetchArticles();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        titleSpacing: -8,
        title: Text(
          'Artikel',
          style: NendaStyles.fontBold,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 24, top: 16, right: 24),
        child: Column(
          children: [
            AppSearchBar(
              controller: _searchController,
              hintText: 'Cari Artikel',
              onChanged: (String keyword) =>
                  context.read<ArticleCubit>().searchArtikel(keyword),
            ),
            SizedBox(height: 32),
            BlocConsumer<ArticleCubit, ArticleState>(
              listener: (context, state) {
                if (state is ArticleError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.errorMessage.toString()),
                    backgroundColor: Colors.black,
                  ));
                }
              },
              builder: (context, state) {
                if (state is ArticleSuccess) {
                  var data = state.searchArticles ?? state.articles;
                  return Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: data!.length,
                      itemBuilder: (contex, index) => CardArtikel(
                        data: data[index],
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Center(
                      child: ContentLoadingWidget(),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
