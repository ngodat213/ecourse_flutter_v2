import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:ecourse_flutter_v2/core/widgets/see_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MySearchDelegate extends SearchDelegate {
  final TextStyle? fieldStyle;
  final double? height;

  MySearchDelegate({this.fieldStyle, this.height, String hintText = 'Search'})
    : super(searchFieldLabel: hintText);

  final List<String> data = [
    "Flutter",
    "Dart",
    "React Native",
    "Swift",
    "Kotlin",
    "Java",
  ];

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColor.background,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColor.textPrimary),
      ),
      inputDecorationTheme: searchFieldDecorationTheme,
    );
  }

  @override
  InputDecorationTheme get searchFieldDecorationTheme => InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: AppColor.accent),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: AppColor.accent),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: AppColor.accent),
    ),
    hintStyle: fieldStyle?.copyWith(
      color: Colors.grey,
      fontWeight: FontWeight.w400,
    ),
    isDense: true,
  );

  @override
  String get searchFieldLabel => '';

  @override
  TextStyle? get searchFieldStyle => fieldStyle;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear, size: 20),
          onPressed: () {
            query = ''; // Xóa nội dung tìm kiếm
            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions =
        data
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),

          child: SeeAllWidget(
            title: 'recent_searches'.tr(),
            onSeeAll: () {},
            padding: EdgeInsets.zero,
            seeAllText: 'clear'.tr(),
            seeAllStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 10.sp,
              color: AppColor.primary,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              return buildSuggestionItem(context, suggestions[index]);
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text("Bạn tìm kiếm: $query"));
  }

  Widget buildSuggestionItem(BuildContext context, String suggestion) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColor.accent)),
      ),
      child: ListTile(
        leading: SvgPicture.asset(AppImage.svgSuggestion),
        contentPadding: EdgeInsets.zero,
        minLeadingWidth: 0,
        minTileHeight: 48.h,
        title: Text(
          suggestion,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
        ),
        onTap: () {
          query = suggestion;
          showResults(context);
        },
      ),
    );
  }
}
