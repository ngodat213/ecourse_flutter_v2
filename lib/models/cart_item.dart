import 'package:ecourse_flutter_v2/models/course_model.dart';

class CartItem {
  CourseModel? courseId;
  int? price;
  String? sId;
  String? addedAt;

  CartItem({this.courseId, this.price, this.sId, this.addedAt});

  CartItem.fromJson(Map<String, dynamic> json) {
    courseId =
        json['course_id'] != null
            ? CourseModel.fromJson(json['course_id'])
            : null;
    price = json['price'];
    sId = json['_id'];
    addedAt = json['added_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (courseId != null) {
      data['course_id'] = courseId!.toJson();
    }
    data['price'] = price;
    data['_id'] = sId;
    data['added_at'] = addedAt;
    return data;
  }
}
