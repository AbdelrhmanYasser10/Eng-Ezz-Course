import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_style.dart';

class CategoryWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  const CategoryWidget({
    super.key,
    required this.title,
    required this.imageUrl
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        width: 70,
        height: 80,
        child: Column(
          children: [
            CircleAvatar(
              radius: 36.0,
              backgroundColor: AppColors.kPrimaryColor,
              child: CircleAvatar(
                radius: 32.0,
                backgroundImage: CachedNetworkImageProvider(
                  imageUrl,
                  errorListener: (element) {

                  },
                ),
              ),
            ),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.textStyleFont14BlackRegular(),
            )
          ],
        ),
      ),
    );
  }
}
