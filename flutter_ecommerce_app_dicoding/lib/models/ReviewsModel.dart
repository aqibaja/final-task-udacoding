class ReviewsModel {
  String rating;
  String ulasan;
  String namaLengkap;
  String imageUrl;

  ReviewsModel({this.ulasan, this.namaLengkap, this.imageUrl, this.rating});

  ReviewsModel.fromJson(Map<String, dynamic> json) {
    ulasan = json['ulasan'].toString();
    namaLengkap = json['nama_lengkap'].toString();
    imageUrl = json['foto'];
    rating = json['rating'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ulasank'] = this.ulasan;
    data['nama_lengkap'] = this.namaLengkap;
    data['foto'] = this.imageUrl;
    data['rating'] = this.rating;

    return data;
  }
}
