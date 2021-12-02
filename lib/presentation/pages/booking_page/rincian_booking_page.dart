import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nenda_invfest/constant.dart';
import 'package:nenda_invfest/cubit/ticket/ticket_cubit.dart';
import 'package:nenda_invfest/data/model/ticket_model.dart';
import 'package:nenda_invfest/presentation/pages/booking_page/ticket_notification_page.dart';
import 'package:nenda_invfest/presentation/widgets/app_button_widget.dart';

class RincianBookingPage extends StatelessWidget {
  final TicketModel data;

  RincianBookingPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 24),
              children: [
                SizedBox(height: 32),
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
                      'Ringkasan Booking',
                      style: NendaStyles.fontBold,
                    ),
                  ],
                ),
                SizedBox(height: 32),
                _ticketSummaryCard(),
                SizedBox(height: 32),
                _priceSummary()
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: AppButton(
                  width: double.infinity,
                  height: 52,
                  text: 'Lanjutkan',
                  shadow: [
                    BoxShadow(
                        blurRadius: 20,
                        offset: Offset(0, 10),
                        color: Colors.black26),
                  ],
                  onPressed: () {
                    BlocProvider.of<TicketCubit>(context)
                        .createTicket(data: data);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TicketNotifiactionPage(
                          data: data,
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column _priceSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rincian Pembayaran',
          style: NendaStyles.fontMedium,
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Harga Tiket',
                  style: NendaStyles.fontParagraph,
                ),
                SizedBox(height: 8),
                Text(
                  'Jumlah Pendaki',
                  style: NendaStyles.fontParagraph,
                ),
                SizedBox(height: 8),
                Text(
                  'Total Pembayaran',
                  style: NendaStyles.fontParagraph,
                ),
                SizedBox(height: 16),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Rp. ${data.hargaTicket}',
                  style: NendaStyles.fontParagraph.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Text(
                  '${data.jumlahPendaki}',
                  style: NendaStyles.fontParagraph.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Text(
                  'Rp. ${data.totalHarga!.toInt()}',
                  style: NendaStyles.fontParagraph.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 16),
              ],
            )
          ],
        )
      ],
    );
  }

  Container _ticketSummaryCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: kOrange,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${data.namaGunung}',
            style: NendaStyles.fontMedium.copyWith(color: kWhite),
          ),
          SizedBox(height: 32),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nama Ketua',
                    style: NendaStyles.fontParagraph.copyWith(color: kWhite),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No Handphone',
                    style: NendaStyles.fontParagraph.copyWith(color: kWhite),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Email Ketua',
                    style: NendaStyles.fontParagraph.copyWith(color: kWhite),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Jalur Pendakian',
                    style: NendaStyles.fontParagraph.copyWith(color: kWhite),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Tanggal Naik',
                    style: NendaStyles.fontParagraph.copyWith(color: kWhite),
                  ),
                  SizedBox(height: 16),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${data.namaKetua}',
                    style: NendaStyles.fontParagraph.copyWith(
                      color: kWhite,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 16),
                  Text(
                    '${data.noHpKetua}',
                    style: NendaStyles.fontParagraph.copyWith(
                      color: kWhite,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 16),
                  Text(
                    '${data.emailKetua}',
                    style: NendaStyles.fontParagraph.copyWith(
                      color: kWhite,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 16),
                  Text(
                    '${data.jalurPendakian}',
                    style: NendaStyles.fontParagraph.copyWith(
                      color: kWhite,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 16),
                  Text(
                    '${data.tanggalNaik}',
                    style: NendaStyles.fontParagraph.copyWith(
                      color: kWhite,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 16),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
