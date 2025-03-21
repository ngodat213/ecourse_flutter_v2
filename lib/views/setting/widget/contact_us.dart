import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/core/config/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('contact_us'.tr()),
        backgroundColor: AppColor.background,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'contact_description'.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 24.h),
            _buildContactItem(
              context,
              icon: Icons.phone,
              title: 'phone'.tr(),
              value: '+84 123 456 789',
              onTap: () => _launchUrl('tel:+84123456789'),
            ),
            SizedBox(height: 16.h),
            _buildContactItem(
              context,
              icon: Icons.email,
              title: 'email'.tr(),
              value: 'support@ecourse.com',
              onTap: () => _launchUrl('mailto:support@ecourse.com'),
            ),
            SizedBox(height: 16.h),
            _buildContactItem(
              context,
              icon: Icons.location_on,
              title: 'address'.tr(),
              value: '123 Street Name, City, Country',
              onTap:
                  () => _launchUrl(
                    'https://www.google.com/maps/search/?api=1&query=123+Street+Name',
                  ),
            ),
            SizedBox(height: 32.h),
            Text(
              'social_media'.tr(),
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSocialButton(
                  context,
                  icon: Icons.facebook,
                  onTap: () => _launchUrl('https://facebook.com'),
                ),
                _buildSocialButton(
                  context,
                  icon: Icons.messenger,
                  onTap: () => _launchUrl('https://m.me/ecourse'),
                ),
                _buildSocialButton(
                  context,
                  icon: Icons.telegram,
                  onTap: () => _launchUrl('https://t.me/ecourse'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.accent),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColor.primary),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4.h),
                Text(value, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColor.primary.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColor.primary, size: 24.w),
      ),
    );
  }
}
