import 'package:nenda_invfest/data/model/article_model.dart';
import 'package:nenda_invfest/data/model/user_model.dart';

final List<ArticleModel> articleList = [
  ArticleModel(
    title: "6 Tips Mendaki Gunung bagi Pemula, Belajar Olah Makanan",
    author: "Titan Br.",
    publishedAt: "10/09/2021",
    backgroundUrl:
        "https://asset.kompas.com/crops/r_Heon9YKgZDh94B-VS3FWwPNGE=/0x0:780x520/750x500/data/photo/2019/10/07/5d9b24b2ba587.jpg",
  ),
  ArticleModel(
    title: "Pengenalan Pendakian Gunung",
    author: "Titan Br.",
    publishedAt: "10/09/2021",
    backgroundUrl:
        "https://i1.wp.com/penjelajah.com/wp-content/uploads/2018/06/Hiking.jpg?w=1024&ssl=1",
  ),
  ArticleModel(
    title:
        "15 Tips Buat Para Cewek yang Mau Mendaki Gunung. Tetap Bisa Cantik dan Sampai Puncak!",
    author: "Titan Br.",
    publishedAt: "10/09/2021",
    backgroundUrl:
        "https://www.mongabay.co.id/wp-content/uploads/2021/07/Para-pendaki-beristirahat-di-Ranukumbolo-salah-satu-shelter-jalur-pendakian-Gunung-Semeru.-Foto-Nopri-Ismi-Mongabay-Indonesia.jpg",
  ),
];

final UserModel dummyUser = UserModel(
  namaLengkap: "Titan Bagus Br.",
  email: "titan@gmail.com",
  nik: "340200000000",
  kewarganegaraan: "WNI",
  noHandphone: "0812345647",
  username: "titanbr",
  password: "12345",
);
