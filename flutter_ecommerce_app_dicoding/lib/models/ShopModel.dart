/* class ShopModel {
  bool success;
  String message;
  int count;
  List<Data> data;

  ShopModel({this.success, this.message, this.count, this.data});

  ShopModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    count = json['count'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
} */

class ShopModel {
  String slug;
  String contactNumber;
  String shopName;
  String shopImage;
  String approval;
  String ownerName;

  ShopModel(
      {this.slug,
      this.contactNumber,
      this.shopName,
      this.shopImage,
      this.approval,
      this.ownerName});

  ShopModel.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    contactNumber = json['no_telpon'];
    shopName = json['nama_reseller'];
    shopImage = json['foto'];
    approval = json['verifikasi'];
    ownerName = json['user_reseller'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['contact_number'] = this.contactNumber;
    data['shop_name'] = this.shopName;
    data['shop_image'] = this.shopImage;
    data['approval'] = this.approval;
    data['owner_name'] = this.ownerName;
    return data;
  }
}
