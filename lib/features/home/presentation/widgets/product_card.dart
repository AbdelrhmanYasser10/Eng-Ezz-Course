import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/data/models/product_model.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/entities/product_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/pages/product_details_page.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_style.dart';
import '../../../../generated/l10n.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity productModel;

  const ProductCard({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductDetailsPage(productModel: productModel)));
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
              ),
              child: CachedNetworkImage(imageUrl: productModel.images![0]),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productModel.title!,
                    style: AppTextStyle.textStyleFont16BlackBold(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    productModel.description!,
                    style: AppTextStyle.textStyleFont14GreyNormal(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${productModel.price} ${S.of(context).egp}",
                    style: AppTextStyle.textStyleFont14GreyNormal().copyWith(
                      color: AppColors.kPrimaryColor,
                      fontWeight: FontWeight.w500,
                    ),

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
