import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/mixin/video_player_mixin.dart';
import 'package:ecourse_flutter_v2/models/course_model.dart';
import 'package:ecourse_flutter_v2/view_models/course_learn_vm.dart';
import 'package:ecourse_flutter_v2/views/course_learn/widget/course_learn_appbar.dart';
import 'package:ecourse_flutter_v2/views/course_learn/widget/course_learn_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/base/base_view.dart';

class CourseLearnView extends BaseView<CourseLearnVM> {
  const CourseLearnView({super.key});

  @override
  CourseLearnVM createViewModel(
    BuildContext context,
    Map<String, dynamic>? arguments,
  ) {
    final CourseModel course = CourseModel.fromJson(arguments!);
    return CourseLearnVM(context, course);
  }

  @override
  Widget buildView(BuildContext context, CourseLearnVM vm) {
    return CourseLearnScreen(viewModel: vm);
  }
}

class CourseLearnScreen extends StatefulWidget {
  const CourseLearnScreen({super.key, required this.viewModel});
  final CourseLearnVM viewModel;

  @override
  State<CourseLearnScreen> createState() => _CourseLearnScreenState();
}

class _CourseLearnScreenState extends State<CourseLearnScreen>
    with SingleTickerProviderStateMixin, ChewiePlayerMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Khởi tạo video player với URL ban đầu
    if (widget.viewModel.videoUrl != null) {
      initializePlayer(widget.viewModel.videoUrl!);
    }

    // Đăng ký callback khi URL video thay đổi
    widget.viewModel.onVideoUrlChanged = () {
      if (widget.viewModel.videoUrl != null) {
        initializePlayer(widget.viewModel.videoUrl!);
      }
    };
  }

  @override
  void dispose() {
    _tabController.dispose();
    widget.viewModel.onVideoUrlChanged = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CourseLearnAppBar(title: widget.viewModel.course?.title ?? ''),
        backgroundColor: AppColor.background,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.viewModel.videoUrl != null)
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    margin: EdgeInsets.all(8.w),
                    child: buildVideoPlayer(),
                  ),
                )
              else
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    margin: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: AppColor.secondary,
                      borderRadius: BorderRadius.circular(8.r),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          widget.viewModel.course?.thumnail?.url ?? '',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              CourseTabBar(
                course: widget.viewModel.course!,
                tabController: _tabController,
                lessons: widget.viewModel.lessons,
                lessonProgress: widget.viewModel.lessonProgress,
                currentLessonContentId:
                    widget.viewModel.currentProgressId ?? '',
                onContentSelected: (content) {
                  widget.viewModel.onContentSelected(content);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
