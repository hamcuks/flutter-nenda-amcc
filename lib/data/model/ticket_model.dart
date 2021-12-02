class TicketModel {
  String? userId;
  dynamic hargaTicket;
  double? totalHarga;
  int? jumlahPendaki;
  String? tanggalNaik;
  String? namaKetua;
  String? emailKetua;
  String? noHpKetua;
  String? namaGunung;
  String? jalurPendakian;
  List<DataAnggota>? anggota;

  TicketModel({
    this.userId,
    this.hargaTicket,
    this.totalHarga,
    this.jumlahPendaki,
    this.tanggalNaik,
    this.namaKetua,
    this.emailKetua,
    this.noHpKetua,
    this.anggota,
    this.jalurPendakian,
    this.namaGunung,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
        userId: json['user_id'] != null ? json['user_id'] : '',
        hargaTicket: json['harga_ticket'] != null ? json['harga_ticket'] : 0.0,
        totalHarga: json['total_harga'] != null ? json['total_harga'] : 0.0,
        jumlahPendaki:
            json['jumlah_pendaki'] != null ? json['jumlah_pendaki'] : 0,
        tanggalNaik: json['tanggal_naik'] != null ? json['tanggal_naik'] : '',
        namaKetua: json['nama_ketua'] != null ? json['nama_ketua'] : '',
        emailKetua: json['email_ketua'] != null ? json['email_ketua'] : '',
        noHpKetua: json['no_hp_ketua'] != null ? json['no_hp_ketua'] : '',
        namaGunung: json['nama_gunung'] != null ? json['nama_gunung'] : '',
        jalurPendakian:
            json['jalur_pendakian'] != null ? json['jalur_pendakian'] : '',
        anggota: json['anggota'] != null
            ? List<DataAnggota>.from(
                json['anggota'].map((e) => DataAnggota.fromJson(e)))
            : <DataAnggota>[],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "harga_ticket": hargaTicket,
        "total_harga": totalHarga,
        "jumlah_pendaki": jumlahPendaki,
        "tanggal_naik": tanggalNaik,
        "nama_ketua": namaKetua,
        "email_ketua": emailKetua,
        "no_hp_ketua": noHpKetua,
        "nama_gunung": namaGunung,
        "jalur_pendakian": jalurPendakian,
        "anggota": anggota!.map((e) => e.toJson()).toList(),
      };
}

class DataAnggota {
  String? namaLengkap;
  String? email;
  String? nik;
  String? noHp;

  DataAnggota({
    this.namaLengkap,
    this.email,
    this.noHp,
    this.nik,
  });

  factory DataAnggota.fromJson(Map<String, dynamic> json) => DataAnggota(
        namaLengkap: json['nama_lengkap'] != null ? json['nama_lengkap'] : '',
        email: json['email'] != null ? json['email'] : '',
        nik: json['nik'] != null ? json['nik'] : 0,
        noHp: json['no_hp'] != null ? json['no_hp'] : 0,
      );

  Map<String, dynamic> toJson() => {
        "nama_lengkap": namaLengkap,
        "email": email,
        "nik": nik,
        "no_hp": noHp,
      };
}
