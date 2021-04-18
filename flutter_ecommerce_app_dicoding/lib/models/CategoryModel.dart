class CategoryModel {
  String name_category;
  String icon;
  String imageUrl;
  String idKategori;

  CategoryModel(
      {this.name_category, this.icon, this.imageUrl, this.idKategori});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    name_category = json['nama_kategori'];
    icon = json['icon_kode'];
    imageUrl = json['gambar'];
    idKategori = json['id_kategori_produk'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama_kategori'] = this.name_category;
    data['icon_kode'] = this.icon;
    data['gambar'] = this.imageUrl;
    data['id_kategori_produk'] = this.idKategori;
    return data;
  }
}
