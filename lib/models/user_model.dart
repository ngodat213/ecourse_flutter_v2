import 'package:ecourse_flutter_v2/models/course_model.dart';

enum UserRole { student, instructor, admin, superAdmin }

enum UserStatus { pending, active, blocked }

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? profilePicture;
  final UserRole role;
  final UserStatus status;
  final DateTime? lastLogin;
  final int certificateCount;
  final List<String> enrolledCourses;
  final List<String> teachingCourses;
  final int unreadNotifications;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.profilePicture,
    required this.role,
    required this.status,
    this.lastLogin,
    this.certificateCount = 0,
    this.enrolledCourses = const [],
    this.teachingCourses = const [],
    this.unreadNotifications = 0,
  });

  String get fullName => '$firstName $lastName';

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      email: map['email'] ?? '',
      profilePicture: map['profile_picture'],
      role: _parseRole(map['role']),
      status: _parseStatus(map['status']),
      lastLogin:
          map['last_login'] != null ? DateTime.parse(map['last_login']) : null,
      certificateCount: map['certificate_count'] ?? 0,
      enrolledCourses: List<String>.from(map['enrolled_courses'] ?? []),
      teachingCourses: List<String>.from(map['teaching_courses'] ?? []),
      unreadNotifications: map['unread_notifications'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'profile_picture': profilePicture,
      'role': _roleToString(role),
      'status': _statusToString(status),
      'last_login': lastLogin?.toIso8601String(),
      'certificate_count': certificateCount,
      'enrolled_courses': enrolledCourses,
      'teaching_courses': teachingCourses,
      'unread_notifications': unreadNotifications,
    };
  }

  static UserRole _parseRole(String? role) {
    switch (role) {
      case 'student':
        return UserRole.student;
      case 'instructor':
        return UserRole.instructor;
      case 'admin':
        return UserRole.admin;
      case 'super_admin':
        return UserRole.superAdmin;
      default:
        return UserRole.student;
    }
  }

  static String _roleToString(UserRole role) {
    switch (role) {
      case UserRole.student:
        return 'student';
      case UserRole.instructor:
        return 'instructor';
      case UserRole.admin:
        return 'admin';
      case UserRole.superAdmin:
        return 'super_admin';
    }
  }

  static UserStatus _parseStatus(String? status) {
    switch (status) {
      case 'pending':
        return UserStatus.pending;
      case 'active':
        return UserStatus.active;
      case 'blocked':
        return UserStatus.blocked;
      default:
        return UserStatus.pending;
    }
  }

  static String _statusToString(UserStatus status) {
    switch (status) {
      case UserStatus.pending:
        return 'pending';
      case UserStatus.active:
        return 'active';
      case UserStatus.blocked:
        return 'blocked';
    }
  }

  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? profilePicture,
    UserRole? role,
    UserStatus? status,
    DateTime? lastLogin,
    int? certificateCount,
    List<String>? enrolledCourses,
    List<String>? teachingCourses,
    int? unreadNotifications,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
      role: role ?? this.role,
      status: status ?? this.status,
      lastLogin: lastLogin ?? this.lastLogin,
      certificateCount: certificateCount ?? this.certificateCount,
      enrolledCourses: enrolledCourses ?? this.enrolledCourses,
      teachingCourses: teachingCourses ?? this.teachingCourses,
      unreadNotifications: unreadNotifications ?? this.unreadNotifications,
    );
  }
}
