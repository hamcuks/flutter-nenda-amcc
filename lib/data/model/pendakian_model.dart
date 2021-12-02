class PendakianModel {
  PendakianModel(
      {this.id,
      this.namaGunung,
      this.deskripsi,
      this.lokasiGunung,
      this.tinggiGunung,
      this.estimasiSummit,
      this.kuota,
      this.medanPendakian,
      this.levelKesulitan,
      this.estimasiHarga,
      this.imagePath,
      this.administrasi,
      this.jalurPendakian,
      this.rating});

  String? id;
  String? namaGunung;
  String? deskripsi;
  String? lokasiGunung;
  String? medanPendakian;
  String? levelKesulitan;
  String? imagePath;
  int? tinggiGunung;
  dynamic estimasiSummit;
  int? kuota;
  int? estimasiHarga;
  dynamic rating;
  List<String>? administrasi;
  List<JalurPendakian>? jalurPendakian;

  factory PendakianModel.fromJson(Map<String, dynamic> json) => PendakianModel(
        id: json["id"] == null ? null : json["id"],
        namaGunung: json["nama_gunung"] == null ? null : json["nama_gunung"],
        deskripsi:
            json["deskripsi_gunung"] == null ? null : json["deskripsi_gunung"],
        lokasiGunung:
            json["lokasi_gunung"] == null ? null : json["lokasi_gunung"],
        tinggiGunung:
            json["tinggi_gunung"] == null ? null : json["tinggi_gunung"],
        estimasiSummit:
            json["estimasi_summit"] == null ? null : json["estimasi_summit"],
        kuota: json["kuota"] == null ? null : json["kuota"],
        medanPendakian:
            json["medan_pendakian"] == null ? null : json["medan_pendakian"],
        levelKesulitan:
            json["level_kesulitan"] == null ? null : json["level_kesulitan"],
        estimasiHarga:
            json["estimasi_harga"] == null ? null : json["estimasi_harga"],
        imagePath: json["image_path"] == null ? null : json["image_path"],
        rating: json["rating"] == null ? null : json['rating'],
        administrasi: json["administrasi"] == null
            ? null
            : List<String>.from(json["administrasi"].map((x) => x)),
        jalurPendakian: json["jalur_pendakian"] == null
            ? null
            : List<JalurPendakian>.from(
                json["jalur_pendakian"].map((x) => JalurPendakian.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nama_gunung": namaGunung == null ? null : namaGunung,
        "deskripsi_gunung": deskripsi == null ? null : deskripsi,
        "lokasi_gunung": lokasiGunung == null ? null : lokasiGunung,
        "tinggi_gunung": tinggiGunung == null ? null : tinggiGunung,
        "estimasi_summit": estimasiSummit == null ? null : estimasiSummit,
        "kuota": kuota == null ? null : kuota,
        "medan_pendakian": medanPendakian == null ? null : medanPendakian,
        "level_kesulitan": levelKesulitan == null ? null : levelKesulitan,
        "estimasi_harga": estimasiHarga == null ? null : estimasiHarga,
        "image_path": imagePath == null ? null : imagePath,
        "administrasi": administrasi == null ? null : administrasi,
        "jalur_pendakian": jalurPendakian == null ? null : jalurPendakian,
      };
}

class JalurPendakian {
  JalurPendakian({
    this.namaJalur,
    this.hargaTiket,
    this.lat,
    this.lon,
  });

  String? namaJalur;
  double? hargaTiket;
  double? lat;
  double? lon;

  factory JalurPendakian.fromJson(Map<String, dynamic> json) => JalurPendakian(
        namaJalur: json["nama_jalur"] == null ? null : json["nama_jalur"],
        hargaTiket:
            json["harga_tiket"] == null ? null : json["harga_tiket"].toDouble(),
        lat: json['lat'] == null ? 0 : json['lat'],
        lon: json['lon'] == null ? 0 : json['lon'],
      );

  Map<String, dynamic> toJson() => {
        "nama_jalur": namaJalur == null ? null : namaJalur,
        "harga_tiket": hargaTiket == null ? null : hargaTiket,
        "lat": lat,
        "lon": lon,
      };
}
