class SliderModel {
  String imageUrl;
  String desc;

  SliderModel({
    this.imageUrl,
    this.desc,
  });

  SliderModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['gambar'];
    desc = json['keterangan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gambar'] = this.imageUrl;
    data['keterangan'] = this.desc;
    return data;
  }
}
