class Thumbnail {
  String? sId;
  String? publicId;

  Thumbnail({this.sId, this.publicId});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    publicId = json['public_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['public_id'] = publicId;
    return data;
  }
}
