import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nenda_invfest/constant.dart';
import 'package:nenda_invfest/data/model/TextFieldContollerModel.dart';
import 'package:nenda_invfest/data/model/ticket_model.dart';
import 'package:nenda_invfest/presentation/pages/booking_page/rincian_booking_page.dart';
import 'package:nenda_invfest/presentation/widgets/app_button_widget.dart';
import 'package:nenda_invfest/presentation/widgets/app_input_widget.dart';

class BookingDetailHikerPage extends StatefulWidget {
  final String jalurPendakian;
  final int hargaTiket;
  final int jumlahPendaki;
  final String tanggalNaik;
  final String namaGunung;

  const BookingDetailHikerPage({
    Key? key,
    required this.jalurPendakian,
    required this.hargaTiket,
    required this.jumlahPendaki,
    required this.tanggalNaik,
    required this.namaGunung,
  }) : super(key: key);

  @override
  _BookingDetailHikerPageState createState() => _BookingDetailHikerPageState();
}

class _BookingDetailHikerPageState extends State<BookingDetailHikerPage> {
  List<TextFieldControllerModel> _controllers = [];
  final User? user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();

  void generateControllers() {
    for (int i = 0; i < widget.jumlahPendaki; i++) {
      _controllers.add(TextFieldControllerModel());
    }
  }

  @override
  void initState() {
    generateControllers();
    super.initState();
  }

  @override
  void dispose() {
    for (int i = 0; i < widget.jumlahPendaki; i++) {
      _controllers[i].nama.dispose();
      _controllers[i].email.dispose();
      _controllers[i].noHp.dispose();
      _controllers[i].nik.dispose();
    }
    _controllers.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Stack(
            children: [
              ListView(
                children: [
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
                        'Detail Pendaki',
                        style: NendaStyles.fontBold,
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          for (int i = 0; i < widget.jumlahPendaki; i++)
                            FormDataPendaki(
                                index: i, controller: _controllers[i]),
                        ],
                      )),
                  SizedBox(height: 48),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
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
                    if (_formKey.currentState!.validate()) {
                      TicketModel _ticket = TicketModel(
                        userId: user!.uid,
                        namaGunung: widget.namaGunung,
                        namaKetua: _controllers[0].nama.text,
                        emailKetua: _controllers[0].email.text,
                        noHpKetua: _controllers[0].noHp.text,
                        hargaTicket: widget.hargaTiket,
                        totalHarga: (widget.hargaTiket * widget.jumlahPendaki)
                            .toDouble(),
                        tanggalNaik: widget.tanggalNaik,
                        jumlahPendaki: widget.jumlahPendaki,
                        jalurPendakian: widget.jalurPendakian,
                        anggota: List<DataAnggota>.from(
                          _controllers.map(
                            (e) => DataAnggota(
                              namaLengkap: e.nama.text,
                              email: e.email.text,
                              noHp: e.noHp.text,
                              nik: e.nik.text,
                            ),
                          ),
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RincianBookingPage(data: _ticket),
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FormDataPendaki extends StatelessWidget {
  final int index;
  final TextFieldControllerModel controller;

  const FormDataPendaki({
    Key? key,
    required this.index,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.only(bottom: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 4), blurRadius: 10, color: Colors.grey[300]!),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (index == 0) ? 'Ketua' : 'Pendaki $index',
            style: NendaStyles.fontMedium,
          ),
          SizedBox(height: 32),
          AppInput(
            label: 'Nama Lengkap',
            hintText: 'Masukkan Nama Lengkap',
            controller: controller.nama,
          ),
          SizedBox(height: 32),
          AppInput(
            label: 'Email',
            hintText: 'Masukkan Email',
            controller: controller.email,
            type: TextInputType.emailAddress,
          ),
          SizedBox(height: 32),
          AppInput(
            label: 'NIK',
            hintText: 'Masukkan NIK',
            controller: controller.nik,
            type: TextInputType.number,
          ),
          SizedBox(height: 32),
          AppInput(
            label: 'No Handphone',
            hintText: 'Masukkan No Handphone',
            controller: controller.noHp,
            type: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
