import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nenda_invfest/data/model/article_model.dart';
import 'package:nenda_invfest/presentation/pages/artikel/detail_artikel_page.dart';

import '../../constant.dart';

class CardArtikel extends StatelessWidget {
  final ArticleModel data;
  const CardArtikel({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailArtikelPage(data: data),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 32),
        child: Container(
          clipBehavior: Clip.antiAlias,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 100,
                child: Image(
                  image: CachedNetworkImageProvider('${data.imagePath}'),
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.title}',
                      style: NendaStyles.fontMedium,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text('${data.author} - ${data.publishedAt}'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
