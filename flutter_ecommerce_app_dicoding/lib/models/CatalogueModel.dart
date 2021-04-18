class CatalogueModel {
  String name;
  String imageUrls;
  String idProduct;
  String price;
  String priceDiscount; //harga_konsumen - diskon
  String rating;

  CatalogueModel(
      {this.name,
      this.price,
      this.priceDiscount,
      this.idProduct,
      this.imageUrls,
      this.rating});

  CatalogueModel.fromJson(Map<String, dynamic> json) {
    name = json['nama_produk'];
    idProduct = json['id_produk'].toString();
    price = json['harga_konsumen'].toString();
    priceDiscount = json['fix_harga'].toString();
    imageUrls = json['gambar'];
    rating = json['rating'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama_produk'] = this.name;
    data['id_produk'] = this.name;
    data['harga_konsumen'] = this.price;
    data['fix_harga'] = this.priceDiscount;
    data['image_urls'] = this.imageUrls;
    data['rating'] = this.rating;

    return data;
  }
}
