class AvtarImageListModel {
  AvtarImageListModel({
    this.status,
    this.avtarImages,
  });
  bool? status;
  List<AvtarImages>? avtarImages;

  AvtarImageListModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    avtarImages = json['avtar_images'] == null ? json['avtar_images'] : List.from(json['avtar_images']).map((e)=>AvtarImages.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['avtar_images'] = avtarImages!.map((e)=>e.toJson()).toList();
    return data;
  }
}

class AvtarImages {
  AvtarImages({
    this.id,
    this.avtarName,
    this.createdAt,
    this.updatedAt,
    this.avtarLink,
  });
  dynamic id;
  String? avtarName;
  dynamic createdAt;
  dynamic updatedAt;
  String? avtarLink;

  AvtarImages.fromJson(Map<String, dynamic> json){
    id = json['id'];
    avtarName = json['avtar_name'];
    avtarLink = json['avtar_link'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['avtar_name'] = avtarName;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['avtar_link'] = avtarLink;
    return _data;
  }
}