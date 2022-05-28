import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nenda_invfest/constant.dart';
import 'package:nenda_invfest/cubit/auth/auth_cubit.dart';
import 'package:nenda_invfest/data/model/pendakian_model.dart';
import 'package:nenda_invfest/presentation/pages/booking_page/booking_detail_hiker_page.dart';
import 'package:nenda_invfest/presentation/pages/pendakian/forecast_pendakian_page.dart';
import 'package:nenda_invfest/presentation/widgets/app_button_widget.dart';
import 'package:nenda_invfest/presentation/widgets/app_date_picker_widget.dart';
import 'package:nenda_invfest/presentation/widgets/app_dropdown_widget.dart';
import 'package:nenda_invfest/presentation/widgets/app_input_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DetailPendakianPage extends StatefulWidget {
  final PendakianModel data;

  DetailPendakianPage({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailPendakianPage> createState() => _DetailPendakianPageState();
}

class _DetailPendakianPageState extends State<DetailPendakianPage> {
  final PanelController _panelController = PanelController();
  TextEditingController _jalurPendakianController = TextEditingController();
  TextEditingController _jumlahPendakiController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _jalurPendakianController.dispose();
    _jumlahPendakiController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry borderRadius = BorderRadius.only(
        topLeft: Radius.circular(25), topRight: Radius.circular(25));
    return Scaffold(
      body: SlidingUpPanel(
        controller: _panelController,
        backdropEnabled: true,
        borderRadius: borderRadius,
        maxHeight: MediaQuery.of(context).size.height * 0.5,
        minHeight: 0,
        panel: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(borderRadius: borderRadius),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pendakian',
                style: NendaStyles.fontBold,
              ),
              SizedBox(height: 16),
              AppDropdown(
                data: widget.data.jalurPendakian!,
                controller: _jalurPendakianController,
              ),
              AppInput(
                hintText: 'Jumlah Pendaki',
                type: TextInputType.number,
                controller: _jumlahPendakiController,
              ),
              SizedBox(height: 24),
              AppDatePicker(
                controller: _dateController,
              ),
              Spacer(),
              BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthInitial)
                    Navigator.pushNamed(context, '/login');

                  if (state is AuthSuccess) {
                    if (_jumlahPendakiController.text.isNotEmpty &&
                        _jalurPendakianController.text.isNotEmpty &&
                        _dateController.text.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingDetailHikerPage(
                            jumlahPendaki:
                                int.parse(_jumlahPendakiController.text),
                            tanggalNaik: _dateController.text,
                            jalurPendakian: _jalurPendakianController.text,
                            hargaTiket: widget.data.estimasiHarga!,
                            namaGunung: widget.data.namaGunung!,
                          ),
                        ),
                      );
                    }
                  }
                },
                child: AppButton(
                  width: double.infinity,
                  height: 52,
                  text: 'Lanjutkan',
                  onPressed: () {
                    context.read<AuthCubit>().checkUser();
                  },
                ),
              )
            ],
          ),
        ),
        body: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Stack(
      children: [
        ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                color: kLightGrey,
                image: DecorationImage(
                  image: CachedNetworkImageProvider('${widget.data.imagePath}'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back_ios),
                      ),
                      SizedBox(width: 8),
                      Text('${widget.data.namaGunung}',
                          style: NendaStyles.fontBold),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    '${widget.data.deskripsi}',
                    style: NendaStyles.fontParagraph
                        .copyWith(fontWeight: FontWeight.w200, height: 1.6),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text('Lokasi Pendakian', style: NendaStyles.fontBold),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    '${widget.data.lokasiGunung}',
                    style: NendaStyles.fontParagraph
                        .copyWith(fontWeight: FontWeight.w200, height: 1.6),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text('Informasi Pendakian', style: NendaStyles.fontBold),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.data.tinggiGunung} Mdpl',
                                style: NendaStyles.fontParagraph
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Tinggi Gunung',
                                style: NendaStyles.fontParagraph
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.data.estimasiSummit} Jam',
                                style: NendaStyles.fontParagraph
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Estimasi Summit',
                                style: NendaStyles.fontParagraph
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.data.kuota}',
                                style: NendaStyles.fontParagraph
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Kuota Per Hari',
                                style: NendaStyles.fontParagraph
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.data.medanPendakian}',
                                style: NendaStyles.fontParagraph
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Medan',
                                style: NendaStyles.fontParagraph
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.data.levelKesulitan}',
                                style: NendaStyles.fontParagraph
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Level',
                                style: NendaStyles.fontParagraph
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rp.${widget.data.estimasiHarga}',
                                style: NendaStyles.fontParagraph
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Harga Per Orang',
                                style: NendaStyles.fontParagraph
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Prakiraan Cuaca', style: NendaStyles.fontBold),
                      Column(
                        children: List.from(
                          widget.data.jalurPendakian!.map(
                            (e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ' ${widget.data.jalurPendakian!.indexOf(e) + 1}. ${e.namaJalur}',
                                    overflow: TextOverflow.clip,
                                    style: NendaStyles.fontParagraph
                                        .copyWith(height: 1.4),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ForecastPendakianPage(
                                          data: e,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      'Lihat Cuaca',
                                      style: NendaStyles.fontParagraph.copyWith(
                                          color: kOrange, height: 1.4),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Informasi Administrasi',
                          style: NendaStyles.fontBold),
                      Column(
                        children: List.from(
                          widget.data.administrasi!.map(
                            (e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${widget.data.administrasi!.indexOf(e) + 1}. ',
                                    style: NendaStyles.fontParagraph
                                        .copyWith(height: 1.4),
                                  ),
                                  SizedBox(width: 4),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Text(
                                      '$e',
                                      overflow: TextOverflow.clip,
                                      style: NendaStyles.fontParagraph
                                          .copyWith(height: 1.4),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.all(24),
            child: AppButton(
              width: double.infinity,
              height: 52,
              text: 'Mulai Pendakian!',
              shadow: [
                BoxShadow(
                    blurRadius: 20,
                    offset: Offset(0, 10),
                    color: Colors.black26),
              ],
              onPressed: () {
                _panelController.open();
              },
            ),
          ),
        )
      ],
    );
  }
}
