import 'package:ecourse_flutter_v2/app/data/models/course_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/payment_method.dart';

class OrderModel {
  String? sId;
  String? orderId;
  String? userId;
  int? amount;
  List<CourseModel>? courses;
  String? status;
  PaymentType? paymentMethod;
  String? createdAt;
  String? updatedAt;
  String? completedAt;
  int? iV;

  OrderModel({
    this.sId,
    this.orderId,
    this.userId,
    this.amount,
    this.courses,
    this.status,
    this.paymentMethod,
    this.createdAt,
    this.updatedAt,
    this.completedAt,
    this.iV,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    orderId = json['order_id'];
    userId = json['user_id'];
    amount = json['amount'];
    if (json['courses'] != null) {
      courses = <CourseModel>[];
      json['courses'].forEach((v) {
        courses!.add(CourseModel.fromJson(v));
      });
    }
    status = json['status'];
    paymentMethod = PaymentType.values.byName(json['payment_method']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    completedAt = json['completed_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['order_id'] = orderId;
    data['user_id'] = userId;
    data['amount'] = amount;
    if (courses != null) {
      data['courses'] = courses!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['payment_method'] = paymentMethod;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['completed_at'] = completedAt;
    data['__v'] = iV;
    return data;
  }
}
