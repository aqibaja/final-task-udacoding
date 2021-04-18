class SubCategoryModel {
  String nameSubCategory;
  String icon;
  String imageUrl;
  String idSubKategori;
  //String rating;
  // String ulasan;

  SubCategoryModel(
      {this.nameSubCategory, this.icon, this.imageUrl, this.idSubKategori});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    nameSubCategory = json['nama_kategori_sub'];
    icon = json['icon_kode'];
    imageUrl = json['icon_image'];
    idSubKategori = json['id_kategori_produk_sub'].toString();
    //rating = json['rating'];
    // ulasan = json['ulasan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama_kategori'] = this.nameSubCategory;
    data['icon_kode'] = this.icon;
    data['gambar'] = this.imageUrl;
    data['id_kategori_produk_sub'] = this.idSubKategori;
    //data['rating'] = this.rating;
    //data['ulasan'] = this.ulasan;
    return data;
  }
}
