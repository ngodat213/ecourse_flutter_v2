import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/models/course_model.dart';
import 'package:ecourse_flutter_v2/repositories/cart_repository.dart';

class CourseDetailVM extends BaseVM {
  final CartRepository _cartRepository = CartRepository();
  CourseDetailVM(super.context, {this.course});

  final CourseModel? course;

  Future<void> addToCart() async {
    final response = await _cartRepository.addToCart(course?.sId ?? '');
    if (response.allGood) {
      setError('Đã thêm vào giỏ hàng');
    } else {
      setError('Không thể thêm vào giỏ hàng');
    }
  }
}
