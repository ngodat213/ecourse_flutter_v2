import 'package:ecourse_flutter_v2/app/data/models/course_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/notification_model.dart';

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
  List<CourseModel>? enrolledCourses;
  // List<Null>? teachingCourses;
  List<NotificationModel>? notifications;
  int? followersCount;
  int? unreadNotifications;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? otp;
  String? otpExpires;
  String? profilePicture;
  String? about;
  String? address;
  String? workingAt;
  String? level;
  int? currentStreak;
  int? longestStreak;

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
    this.enrolledCourses,
    this.followersCount,
    // this.teachingCourses,
    this.notifications,
    this.unreadNotifications,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.otp,
    this.otpExpires,
    this.profilePicture,
    this.about,
    this.address,
    this.workingAt,
    this.level,
    this.currentStreak,
    this.longestStreak,
  });

  String get fullName => '$firstName $lastName';

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
    if (json['enrolled_courses'] != null) {
      enrolledCourses = <CourseModel>[];
      json['enrolled_courses'].forEach((v) {
        enrolledCourses!.add(CourseModel.fromJson(v));
      });
    }
    // if (json['teaching_courses'] != null) {
    //   teachingCourses = <Null>[];
    //   json['teaching_courses'].forEach((v) {
    //     teachingCourses!.add(Null.fromJson(v));
    //   });
    // }
    if (json['notifications'] != null) {
      notifications = <NotificationModel>[];
      json['notifications'].forEach((v) {
        notifications!.add(NotificationModel.fromJson(v));
      });
    }
    unreadNotifications = json['unread_notifications'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
    otp = json['otp'];
    otpExpires = json['otp_expires'];
    profilePicture = json['profile_picture'];
    about = json['about'];
    address = json['address'];
    workingAt = json['working_at'];
    level = json['level'];
    currentStreak = json['current_streak'];
    longestStreak = json['longest_streak'];
    followersCount = json['followers_count'];
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
    if (enrolledCourses != null) {
      data['enrolled_courses'] =
          enrolledCourses!.map((v) => v.toJson()).toList();
    }
    // if (this.teachingCourses != null) {
    //   data['teaching_courses'] =
    //       this.teachingCourses!.map((v) => v.toJson()).toList();
    // }
    if (notifications != null) {
      data['notifications'] = notifications!.map((v) => v.toJson()).toList();
    }
    data['unread_notifications'] = unreadNotifications;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['__v'] = iV;
    data['otp'] = otp;
    data['otp_expires'] = otpExpires;
    data['profile_picture'] = profilePicture;
    data['about'] = about;
    data['address'] = address;
    data['working_at'] = workingAt;
    data['level'] = level;
    data['current_streak'] = currentStreak;
    data['longest_streak'] = longestStreak;
    return data;
  }
}
