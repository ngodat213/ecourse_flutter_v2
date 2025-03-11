import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/base/base_view.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_constants.dart';
import 'package:ecourse_flutter_v2/view_models/chat_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatView extends BaseView<ChatVM> {
  const ChatView({super.key});

  @override
  ChatVM createViewModel(BuildContext context) {
    return ChatVM(context);
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, ChatVM vm) {
    return AppBar(
      toolbarHeight: 80.h,
      title: Text(
        'chat'.tr(),
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 24.sp,
        ),
      ),
      centerTitle: false,
      backgroundColor: AppColor.background,
    );
  }

  @override
  Widget buildView(BuildContext context, ChatVM viewModel) {
    return Column(children: [ChatContent(viewModel: viewModel)]);
  }
}

class ChatContent extends StatefulWidget {
  const ChatContent({super.key, required this.viewModel});
  final ChatVM viewModel;

  @override
  State<ChatContent> createState() => _ChatContentState();
}

class _ChatContentState extends State<ChatContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: AppColor.textPrimary,
          unselectedLabelColor: AppColor.textSecondary,
          tabs: [Text('chats'.tr()), Text('groups'.tr())],
        ),
        SizedBox(
          height: 1.sw,
          child: Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [ChatTabBar(), GroupTabBar()],
            ),
          ),
        ),
      ],
    );
  }
}

class GroupTabBar extends StatelessWidget {
  const GroupTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundImage: AssetImage(AppConstants.defaultAvatar),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                margin: EdgeInsets.only(left: 6.w),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.accent),
                  color: AppColor.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    bottomRight: Radius.circular(8.r),
                    topRight: Radius.circular(8.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Discussion $index',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 1.sw - 107.w,
                      child: Text(
                        'Eu et magna nulla ipsum ad commodo. Proident proident do tempor consequat velit dolore anim non do cupidatat ad tempor. Eiusmod et veniam mollit minim eu magna exercitation do reprehenderit mollit.',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(fontSize: 12.sp),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ChatTabBar extends StatelessWidget {
  const ChatTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 40.h,
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: AppColor.accent,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(AppConstants.defaultAvatar),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Adobe Premiere Pro Course',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '12:00',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    'You: If Anyone wants to ask questions, I’m here t...',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(fontSize: 12.sp),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
