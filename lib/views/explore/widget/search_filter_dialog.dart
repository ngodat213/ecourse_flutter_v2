import 'package:ecourse_flutter_v2/core/widgets/buttons/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/config/app_color.dart';

class SearchFilterDialog extends StatefulWidget {
  const SearchFilterDialog({super.key});

  @override
  State<SearchFilterDialog> createState() => _SearchFilterDialogState();
}

class _SearchFilterDialogState extends State<SearchFilterDialog> {
  final List<String> selectedCategories = [];
  String? selectedPrice;
  String? selectedDuration;

  final List<String> categories = [
    'Design',
    'Visual identity',
    'Marketing',
    'UI/UX',
    'Advertising',
    'Web design',
    'Motion',
  ];

  final List<String> prices = [
    '\$400 - \$600',
    '\$600 - \$900',
    '\$900 - \$1500',
  ];

  final List<String> durations = [
    '15/20 Lesson',
    '20/30 Lesson',
    '30/40 Lesson',
    '40/50 Lesson',
    '50/60 Lesson',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Search Filter',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          titleFilter(context, 'Categories'),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 4.w,
            runSpacing: 2.w,
            children:
                categories.map((category) {
                  final isSelected = selectedCategories.contains(category);
                  return FilterChip(
                    label: textFilterChip(category, context, isSelected),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedCategories.add(category);
                        } else {
                          selectedCategories.remove(category);
                        }
                      });
                    },
                    backgroundColor: Colors.grey[200],
                    selectedColor: AppColor.primary,
                    checkmarkColor: Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  );
                }).toList(),
          ),
          SizedBox(height: 8.h),
          titleFilter(context, 'Price'),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children:
                prices.map((price) {
                  return ChoiceChip(
                    label: textFilterChip(
                      price,
                      context,
                      selectedPrice == price,
                    ),
                    selected: selectedPrice == price,
                    onSelected: (selected) {
                      setState(() {
                        selectedPrice = selected ? price : null;
                      });
                    },
                    backgroundColor: Colors.grey[200],
                    selectedColor: AppColor.primary,
                    labelStyle: TextStyle(
                      color:
                          selectedPrice == price ? Colors.white : Colors.black,
                    ),
                  );
                }).toList(),
          ),
          SizedBox(height: 16.h),
          titleFilter(context, 'Duration'),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children:
                durations.map((duration) {
                  return ChoiceChip(
                    label: textFilterChip(
                      duration,
                      context,
                      selectedDuration == duration,
                    ),
                    selected: selectedDuration == duration,
                    onSelected: (selected) {
                      setState(() {
                        selectedDuration = selected ? duration : null;
                      });
                    },
                    backgroundColor: Colors.grey[200],
                    selectedColor: AppColor.primary,
                    labelStyle: TextStyle(
                      color:
                          selectedDuration == duration
                              ? Colors.white
                              : Colors.black,
                    ),
                  );
                }).toList(),
          ),
          SizedBox(height: 24.h),
          CustomElevatedButton(
            context: context,
            width: 1.sw,
            text: 'Apply Filter',
            onPressed: () {
              // TODO: Apply filter
              Navigator.pop(context, {
                'categories': selectedCategories,
                'price': selectedPrice,
                'duration': selectedDuration,
              });
            },
          ),
          SizedBox(height: 8.h),
          CustomElevatedButton(
            context: context,
            width: 1.sw,
            text: 'Clear All',
            backgroundColor: AppColor.background,
            textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColor.textPrimary,
            ),
            onPressed: () {
              setState(() {
                selectedCategories.clear();
                selectedPrice = null;
                selectedDuration = null;
              });
            },
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Text titleFilter(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Text textFilterChip(String category, BuildContext context, bool isSelected) {
    return Text(
      category,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        fontSize: 10.sp,
        color: isSelected ? AppColor.textPrimaryDark : AppColor.textSecondary,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
