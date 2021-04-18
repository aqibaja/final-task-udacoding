class ProductModels {
  String name;
  String imageUrls;
  String idReseller;
  String berat;
  String idSubKategori;
  String idProduct;
  String price;
  String priceDiscount; //harga_konsumen - diskon
  String deskripsi;
  String detailDeskripsi;
  String minDiscountedPrice;
  String nameVariant;
  String detailVariant;

  ProductModels(
      {this.name,
      this.price,
      this.priceDiscount,
      this.idReseller,
      this.idProduct,
      this.berat,
      this.imageUrls,
      this.idSubKategori,
      this.deskripsi,
      this.detailDeskripsi,
      this.minDiscountedPrice,
      this.nameVariant,
      this.detailVariant});

  ProductModels.fromJson(Map<String, dynamic> json) {
    name = json['nama_produk'];
    idProduct = json['id_produk'].toString();
    price = json['harga_konsumen'].toString();
    priceDiscount = json['fix_harga'].toString();
    imageUrls = json['gambar'];
    idSubKategori = json['id_kategori_produk_sub'].toString();
    deskripsi = json['tentang_produk'];
    detailDeskripsi = json['keterangan'];
    minDiscountedPrice = json['min_discounted_price'];
    berat = json['berat'];
    nameVariant = json['nama'];
    detailVariant = json['variasi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama_produk'] = this.name;
    data['id_produk'] = this.name;
    data['harga_konsumen'] = this.price;
    data['fix_harga'] = this.priceDiscount;
    data['image_urls'] = this.imageUrls;
    data['id_kategori_produk_sub'] = this.idSubKategori;
    data['tentang_produk'] = this.deskripsi;
    data['keterangan'] = this.detailDeskripsi;
    data['min_discounted_price'] = this.minDiscountedPrice;
    data['berat'] = this.berat;
    data['nama'] = this.nameVariant;
    data['variasi'] = this..detailVariant;
    return data;
  }
}
