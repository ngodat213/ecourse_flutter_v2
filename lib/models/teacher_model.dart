class TeacherModel {
  String? sId;
  int? followersCount;
  String? firstName;
  String? lastName;
  String? email;
  String? profilePicture;
  String? createdAt;
  String? updatedAt;
  String? about;
  String? address;
  String? workingAt;
  String? level;

  ///aaaa

  TeacherModel({
    this.sId,
    this.followersCount,
    this.firstName,
    this.lastName,
    this.email,
    this.profilePicture,
    this.createdAt,
    this.updatedAt,
    this.about,
    this.address,
    this.workingAt,
    this.level,
  });

  TeacherModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    followersCount = json['followers_count'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    profilePicture = json['profile_picture'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    about = json['about'];
    address = json['address'];
    workingAt = json['working_at'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sId'] = sId;
    data['followers_count'] = followersCount;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['profile_picture'] = profilePicture;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['about'] = about;
    data['address'] = address;
    data['working_at'] = workingAt;
    data['level'] = level;
    return data;
  }
}
