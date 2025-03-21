import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/widgets/buttons/see_all_button.dart';
import 'package:ecourse_flutter_v2/models/course_model.dart';
import 'package:ecourse_flutter_v2/view_models/explore_vm.dart';
import 'package:ecourse_flutter_v2/views/explore/widget/list_view_course_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MySearchDelegate extends SearchDelegate {
  final TextStyle? fieldStyle;
  final double? height;
  Timer? _debounce;

  MySearchDelegate({this.fieldStyle, this.height, String hintText = 'Search'})
    : super(searchFieldLabel: hintText);

  List<CourseModel> _searchResults = [];
  String _lastQuery = '';

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<List<CourseModel>> _debouncedSearch(
    BuildContext context,
    String query,
  ) async {
    if (query == _lastQuery) {
      return _searchResults;
    }

    _lastQuery = query;
    return context.read<ExploreVM>().searchCourses(query);
  }

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
    if (query.isEmpty) {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            child: SeeAllButton(
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
        ],
      );
    }

    _debounce?.cancel();

    return FutureBuilder<List<CourseModel>>(
      future: Future.delayed(
        const Duration(milliseconds: 500),
        () => _debouncedSearch(context, query),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        _searchResults = snapshot.data ?? [];

        if (_searchResults.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 100.w, color: Colors.grey),
                SizedBox(height: 16.h),
                Text(
                  'no_results_found'.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: _searchResults.length,
          itemBuilder: (context, index) {
            final course = _searchResults[index];
            return ListViewCourseItem(course: course);
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }
}
