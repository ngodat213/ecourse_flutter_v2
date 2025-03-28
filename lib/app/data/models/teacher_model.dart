class TeacherModel {
  String? sId;
  int? followersCount;
  String? firstName;
  String? lastName;
  String? email;
  String? profilePicture;
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
    about = json['about'];
    address = json['address'];
    workingAt = json['working_at'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['followers_count'] = followersCount;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['profile_picture'] = profilePicture;
    data['about'] = about;
    data['address'] = address;
    data['working_at'] = workingAt;
    data['level'] = level;
    return data;
  }
}
