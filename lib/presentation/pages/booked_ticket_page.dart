import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:nenda_invfest/constant.dart';

class BookedTicketPage extends StatelessWidget {
  const BookedTicketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOrange,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tiket Pendakianmu",
                style: NendaStyles.fontBold.copyWith(color: Colors.white),
              ),
              SizedBox(height: 32),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [_ticketQR(), _ticketDivider(), _detailPendaki()],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding _ticketQR() {
    return Padding(
      padding: EdgeInsets.only(top: 32, left: 32, right: 32, bottom: 24),
      child: Column(
        children: [
          Image.asset('assets/images/dummy_qr.webp'),
          SizedBox(
            height: 8,
          ),
          Text(
            "Ticket ID: 345876",
            style: NendaStyles.fontMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Pindai kode ini di basecamp pendakian",
            style: NendaStyles.fontMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Padding _detailPendaki() {
    return Padding(
      padding: EdgeInsets.only(top: 32, left: 32, right: 32, bottom: 24),
      child: Column(
        children: [
          Text(
            "Detail Pendakian",
            style: NendaStyles.fontMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 48,
          ),
          Row(
            children: [
              Text(
                "Nama Gunung",
                style: NendaStyles.fontParagraph,
              ),
              Spacer(),
              Text(
                "Gunung Merbabu",
                style: NendaStyles.fontParagraph
                    .copyWith(fontWeight: FontWeight.w200),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Text(
                "Jalur Pendakian",
                style: NendaStyles.fontParagraph,
              ),
              Spacer(),
              Text(
                "Jalur Thekelan",
                style: NendaStyles.fontParagraph
                    .copyWith(fontWeight: FontWeight.w200),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Text(
                "Tanggal Naik",
                style: NendaStyles.fontParagraph,
              ),
              Spacer(),
              Text(
                "17 Agustus 2022",
                style: NendaStyles.fontParagraph
                    .copyWith(fontWeight: FontWeight.w200),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Text(
                "Jumlah Pendaki",
                style: NendaStyles.fontParagraph,
              ),
              Spacer(),
              Text(
                "5",
                style: NendaStyles.fontParagraph
                    .copyWith(fontWeight: FontWeight.w200),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Row _ticketDivider() {
  return Row(
    children: [
      Container(
        width: 25,
        height: 50,
        decoration: BoxDecoration(
          color: kOrange,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
      ),
      Flexible(
        child: DottedLine(
          lineThickness: 2,
          dashColor: kOrange,
        ),
      ),
      Container(
        width: 25,
        height: 50,
        decoration: BoxDecoration(
          color: kOrange,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
        ),
      )
    ],
  );
}
