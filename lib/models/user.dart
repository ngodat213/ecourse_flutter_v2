class User {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? profilePictureId;
  String? avatarFile;
  String? role;
  String? status;
  int? certificateCount;
  // List<Null>? enrolledCourses;
  // List<Null>? teachingCourses;
  // List<Null>? notifications;
  int? unreadNotifications;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? otp;
  String? otpExpires;
  String? profilePicture;

  User({
    this.sId,
    this.firstName,
    this.lastName,
    this.email,
    this.profilePictureId,
    this.avatarFile,
    this.role,
    this.status,
    this.certificateCount,
    // this.enrolledCourses,
    // this.teachingCourses,
    // this.notifications,
    this.unreadNotifications,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.otp,
    this.otpExpires,
    this.profilePicture,
  });

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    profilePictureId = json['profile_picture_id'];
    avatarFile = json['avatar_file'];
    role = json['role'];
    status = json['status'];
    certificateCount = json['certificate_count'];
    // if (json['enrolled_courses'] != null) {
    //   enrolledCourses = <Null>[];
    //   json['enrolled_courses'].forEach((v) {
    //     enrolledCourses!.add(Null.fromJson(v));
    //   });
    // }
    // if (json['teaching_courses'] != null) {
    //   teachingCourses = <Null>[];
    //   json['teaching_courses'].forEach((v) {
    //     teachingCourses!.add(Null.fromJson(v));
    //   });
    // }
    // if (json['notifications'] != null) {
    //   notifications = <Null>[];
    //   json['notifications'].forEach((v) {
    //     notifications!.add(Null.fromJson(v));
    //   });
    // }
    unreadNotifications = json['unread_notifications'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
    otp = json['otp'];
    otpExpires = json['otp_expires'];
    profilePicture = json['profile_picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['profile_picture_id'] = profilePictureId;
    data['avatar_file'] = avatarFile;
    data['role'] = role;
    data['status'] = status;
    data['certificate_count'] = certificateCount;
    // if (this.enrolledCourses != null) {
    //   data['enrolled_courses'] =
    //       this.enrolledCourses!.map((v) => v.toJson()).toList();
    // }
    // if (this.teachingCourses != null) {
    //   data['teaching_courses'] =
    //       this.teachingCourses!.map((v) => v.toJson()).toList();
    // }
    // if (this.notifications != null) {
    //   data['notifications'] =
    //       this.notifications!.map((v) => v.toJson()).toList();
    // }
    data['unread_notifications'] = unreadNotifications;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['__v'] = iV;
    data['otp'] = otp;
    data['otp_expires'] = otpExpires;
    data['profile_picture'] = profilePicture;
    return data;
  }
}
