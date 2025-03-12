import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/base/base_view.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_constants.dart';
import 'package:ecourse_flutter_v2/view_models/chat_vm.dart';
import 'package:ecourse_flutter_v2/views/chat/chat_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatListView extends BaseView<ChatVM> {
  const ChatListView({super.key});

  @override
  ChatVM createViewModel(
    BuildContext context,
    Map<String, dynamic>? arguments,
  ) {
    return ChatVM(context);
  }

  // @override
  // PreferredSizeWidget? buildAppBar(BuildContext context, ChatVM vm) {
  //   return AppBar(
  //     toolbarHeight: 80.h,
  //     title: Text(
  //       'chat'.tr(),
  //       style: Theme.of(context).textTheme.titleLarge?.copyWith(
  //         fontWeight: FontWeight.w700,
  //         fontSize: 24.sp,
  //       ),
  //     ),
  //     centerTitle: false,
  //     backgroundColor: AppColor.background,
  //   );
  // }

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
          height: 1.sh - 170.h,
          child: Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [ChatTabBar(), ChatTabBar()],
            ),
          ),
        ),
      ],
    );
  }
}

class ChatTabBar extends StatelessWidget {
  const ChatTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => ChatDetailView(chatId: '1'),
              );
            },
            child: Container(
              margin: EdgeInsets.only(top: 12.h, left: 16.w, right: 16.w),
              height: 50.h,
              width: 1.sw - 32.w,
              child: Row(
                children: [
                  Container(
                    width: 50.w,
                    height: 50.w,
                    decoration: BoxDecoration(
                      color: AppColor.accent,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(AppConstants.defaultAvatar),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Adobe Premiere Pro Course',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '12:00',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'You: If Anyone wants to ask questions, I’m here t...',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
