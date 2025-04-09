import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/app/data/models/conversation_model.dart';
import 'package:ecourse_flutter_v2/core/base/base_view.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_constants.dart';
import 'package:ecourse_flutter_v2/view_models/conversation_vm.dart';
import 'package:ecourse_flutter_v2/views/chat/chat_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConversationView extends BaseView<ConversationVM> {
  const ConversationView({super.key});

  @override
  ConversationVM createViewModel(
    BuildContext context,
    Map<String, dynamic>? arguments,
  ) {
    return ConversationVM(context);
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
  Widget buildView(BuildContext context, ConversationVM viewModel) {
    return Column(children: [ChatContent(viewModel: viewModel)]);
  }
}

class ChatContent extends StatefulWidget {
  const ChatContent({super.key, required this.viewModel});
  final ConversationVM viewModel;

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
        SizedBox(
          height: 1.sh - 170.h,
          child: ChatTabBar(conversations: widget.viewModel.groupConversations),
        ),
      ],
    );

    // return Column(
    //   children: [
    //     TabBar(
    //       controller: _tabController,
    //       labelColor: AppColor.textPrimary,
    //       unselectedLabelColor: AppColor.textSecondary,
    //       tabs: [Text('chats'.tr()), Text('groups'.tr())],
    //     ),
    //     SizedBox(
    //       height: 1.sh - 170.h,
    //       child: Expanded(
    //         child: TabBarView(
    //           controller: _tabController,
    //           children: [
    //             ChatTabBar(conversations: widget.viewModel.conversations),
    //             ChatTabBar(conversations: widget.viewModel.groupConversations),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}

class ChatTabBar extends StatelessWidget {
  const ChatTabBar({super.key, required this.conversations});
  final List<ConversationModel> conversations;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder:
                    (context) =>
                        ChatDetailView(conversation: conversations[index]),
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
                            SizedBox(
                              width: 1.sw - 100.w - 32.w,
                              child: Text(
                                conversations[index].name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              conversations[index].lastMessage?.createdAt
                                      .toLocal()
                                      .toString()
                                      .substring(11, 16) ??
                                  '',
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
                          conversations[index].lastMessage?.content ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.textSecondary,
                          ),
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
