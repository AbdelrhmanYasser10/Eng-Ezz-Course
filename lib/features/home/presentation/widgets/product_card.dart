import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/manager/fav_cubit/fav_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/entities/product_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/pages/product_details_page.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_style.dart';
import '../../../../generated/l10n.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity productModel;

  const ProductCard({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsPage(productModel: productModel),
          ),
        );
      },
      child: Stack(
        children: [
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12.r),
                    topLeft: Radius.circular(12.r),
                  ),
                  child: CachedNetworkImage(imageUrl: productModel.images![0]),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productModel.title!,
                        style: AppTextStyle.textStyleFont16BlackBold(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        productModel.description!,
                        style: AppTextStyle.textStyleFont14GreyNormal(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "${productModel.price} ${S.of(context).egp}",
                        style: AppTextStyle.textStyleFont14GreyNormal()
                            .copyWith(
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
          BlocConsumer<FavCubit, FavState>(
            listener: (context, state) {
              log("Current State in the Fav Cubit $state");
            },
            builder: (context, state) {
              var cubit = context.read<FavCubit>();
              bool favProduct = cubit.isInFavourite[productModel.id!] ?? false;
              return Positioned(
                top: 10,
                right: 10,
                child: InkWell(
                  onTap: () {
                    log("PRESSED");
                    cubit.saveToFav(productModel);
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor:favProduct ? Colors.red : Colors.white54,
                    child: Icon(
                      Icons.favorite_border,
                      size: 18,
                      color: favProduct ? Colors.white : Colors.blueGrey,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
