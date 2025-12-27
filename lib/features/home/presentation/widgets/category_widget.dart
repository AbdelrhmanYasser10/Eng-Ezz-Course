import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/entities/category_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/manager/product_cubit/product_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/pages/category_products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_style.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryEntity categoryModel;
  final ProductCubit value;

  const CategoryWidget(
      {super.key, required this.categoryModel, required this.value});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ProductCubit>().getCategoryProducts(categoryModel.id!);
        log("Get all categories");
        Navigator.push(context, MaterialPageRoute(builder: (_) =>
            BlocProvider.value(
              value: value,
              child: CategoryProductsPage(),
            ),),);
      },
      child: Padding(
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
                    categoryModel.image!,
                    errorListener: (element) {},
                  ),
                ),
              ),
              Text(
                categoryModel.name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.textStyleFont14BlackRegular(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
