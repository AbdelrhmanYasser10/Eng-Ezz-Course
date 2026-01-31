import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_app_session_it_sharks/core/styles/app_colors.dart';
import 'package:e_commerce_app_session_it_sharks/core/styles/app_text_style.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/entities/user_entity.dart';


class ProfilePage extends StatelessWidget {
  final UserEntity user;
  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: AppTextStyle.textStyleFont24BlackBold(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0.r),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Center(
              child: CircleAvatar(
                radius: 60.r,
                backgroundColor: AppColors.kPrimaryColor,
                child: CircleAvatar(
                  radius: 56.r,
                  backgroundImage: CachedNetworkImageProvider(
                    user.avatar ?? "https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg",
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              user.name ?? "User Name",
              style: AppTextStyle.textStyleFont24BlackBold(),
            ),
            SizedBox(height: 10.h),
            Text(
              user.email ?? "email@example.com",
              style: AppTextStyle.textStyleFont14GreyNormal().copyWith(fontSize: 16.sp),
            ),
            SizedBox(height: 40.h),
            _buildProfileItem(
              icon: Icons.badge_outlined,
              title: "Role",
              value: user.role ?? "User",
            ),
            if (user.creationAt != null) ...[
              SizedBox(height: 10.h),
              _buildProfileItem(
                icon: Icons.calendar_today_outlined,
                title: "Joined",
                value: _formatDate(user.creationAt!),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem({required IconData icon, required String title, required String value}) {
    return Card(
      elevation: 0,
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: ListTile(
        leading: Icon(icon, color: AppColors.kPrimaryColor, size: 24.sp),
        title: Text(
          title,
          style: AppTextStyle.textStyleFont14GreyNormal(),
        ),
        subtitle: Text(
          value,
          style: AppTextStyle.textStyleFont18BlackBold(),
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      return "${date.day}/${date.month}/${date.year}";
    } catch (e) {
      return dateString;
    }
  }
}
