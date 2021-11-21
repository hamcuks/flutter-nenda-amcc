import 'package:flutter/material.dart';

import '../../constant.dart';

class CardMountain extends StatelessWidget {
  const CardMountain({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(
                        "https://cdn-2.tstatic.net/travel/foto/bank/images/pendaki-gunung-merbabu_20170826_121739.jpg"),
                    fit: BoxFit.fill)),
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            "Gunung Merbabu",
            style: NendaStyles.fontMedium,
          ),
          SizedBox(
            height: 16,
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
                    "Boyolali, Jawa Tengah",
                    style: NendaStyles.fontParagraph,
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
                    "3145 Mdpl",
                    style: NendaStyles.fontParagraph,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
