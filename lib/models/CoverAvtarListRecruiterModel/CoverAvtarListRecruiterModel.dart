class CoverAvtarListRecruiter {
  CoverAvtarListRecruiter({
     this.status,
     this.coverImages,
  });
   bool? status;
   List<CoverImages>? coverImages;

  CoverAvtarListRecruiter.fromJson(Map<String, dynamic> json){
    status = json['status'];
    coverImages = List.from(json['cover_images']).map((e)=>CoverImages.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['cover_images'] = coverImages!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class CoverImages {
  CoverImages({
     this.id,
     this.coverImg,
     this.createdAt,
     this.updatedAt,
     this.coverLink,
  });
   int? id;
   String? coverImg;
  String? createdAt;
   String? updatedAt;
   String? coverLink;

  CoverImages.fromJson(Map<String, dynamic> json){
    id = json['id'];
    coverImg = json['cover_img'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    coverLink = json['cover_link'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['cover_img'] = coverImg;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['cover_link'] = coverLink;
    return _data;
  }
}