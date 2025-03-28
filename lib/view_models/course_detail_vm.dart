import 'package:ecourse_flutter_v2/app/domain/repositories/cart_repository.dart';
import 'package:ecourse_flutter_v2/core/base/base_view_model.dart';
import 'package:ecourse_flutter_v2/app/data/models/course_model.dart';
import 'package:ecourse_flutter_v2/app/data/repositories/cart_repository_impl.dart';

class CourseDetailVM extends BaseVM {
  final CartRepository _cartRepository = CartRepositoryImpl();
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
