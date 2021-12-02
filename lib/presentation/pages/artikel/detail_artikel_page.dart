import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nenda_invfest/constant.dart';
import 'package:nenda_invfest/data/model/article_model.dart';

class DetailArtikelPage extends StatelessWidget {
  final ArticleModel data;

  const DetailArtikelPage({Key? key, required this.data}) : super(key: key);

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
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.25,
            margin: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: kLightGrey,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: CachedNetworkImageProvider('${data.imagePath}'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${data.title}', style: NendaStyles.fontBold),
                SizedBox(
                  height: 16,
                ),
                Text('Oleh ${data.author} pada ${data.publishedAt}',
                    style: NendaStyles.fontParagraph
                        .copyWith(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 16,
                ),
                Text(
                  '${data.description}',
                  style: NendaStyles.fontParagraph
                      .copyWith(fontWeight: FontWeight.w200, height: 1.8),
                ),
                SizedBox(
                  height: 32,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
