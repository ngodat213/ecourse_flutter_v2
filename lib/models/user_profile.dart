import 'package:ecourse_flutter_v2/models/stats.dart';
import 'package:ecourse_flutter_v2/models/user.dart';

class UserProfile {
  User? user;
  Stats? stats;

  UserProfile({this.user, this.stats});

  UserProfile.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (stats != null) {
      data['stats'] = stats!.toJson();
    }
    return data;
  }
}
