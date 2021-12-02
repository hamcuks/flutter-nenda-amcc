import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nenda_invfest/data/model/pendakian_model.dart';
import 'package:nenda_invfest/presentation/pages/pendakian/detail_pendakian_page.dart';

import '../../constant.dart';

class CardMountain extends StatelessWidget {
  final PendakianModel data;
  const CardMountain({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPendakianPage(data: data),
        ),
      ),
      child: Container(
        width: 300,
        margin: EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider('${data.imagePath}'),
                        fit: BoxFit.fill),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 82,
                    height: 48,
                    margin: EdgeInsets.only(top: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow[600],
                        ),
                        SizedBox(width: 8),
                        Text(
                          '${data.rating}',
                          style: NendaStyles.fontParagraph,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              '${data.namaGunung}',
              style: NendaStyles.fontMedium,
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.place,
                      color: kOrange,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '${data.lokasiGunung}',
                      style: NendaStyles.fontParagraph,
                      overflow: TextOverflow.fade,
                    )
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(
                      Icons.timeline,
                      color: kOrange,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '${data.tinggiGunung} Mdpl',
                      style: NendaStyles.fontParagraph,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
