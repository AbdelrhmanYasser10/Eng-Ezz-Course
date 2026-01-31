import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_app_session_it_sharks/core/components/app_button.dart';
import 'package:e_commerce_app_session_it_sharks/core/styles/app_text_style.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/entities/product_entity.dart';
import 'package:e_commerce_app_session_it_sharks/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:see_more_text/see_more_text.dart';

import '../../../../core/styles/app_colors.dart';
import '../manager/product_cubit/product_cubit.dart';
import '../widgets/products_grid_widget.dart';
import 'category_products_page.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductEntity productModel;

  const ProductDetailsPage({super.key, required this.productModel});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().getCategoryProducts(widget.productModel.category!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                items:
                widget.productModel.images!.map((element) {
                  return CachedNetworkImage(
                    imageUrl: element,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 220.h,
                  aspectRatio: 1.1 / 1.2,
                  initialPage: 0,
                  viewportFraction: 1,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.1,
                  onPageChanged: (index, reason) {},
                  scrollDirection: Axis.horizontal,
                ),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.r),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.productModel.title!,
                          style: AppTextStyle.textStyleFont20BlackBold(),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          S.of(context).productDetails,
                          style: AppTextStyle.textStyleFont14BlackRegular()
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 5.0.h),
                        SeeMoreText(
                          text: widget.productModel.description!,
                          maxLines: 3,
                          textStyle:
                          AppTextStyle.textStyleFont12BlackRegular().copyWith(),
                          linkStyle: TextStyle(
                            color: AppColors.kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          seeMoreText: S.of(context).readMore,
                          seeLessText: S.of(context).showLess,
                        ),
                        SizedBox(height: 10.0.h),
                        Row(
                          children: [
                            Text(
                              S.of(context).categories,
                              style: AppTextStyle.textStyleFont14BlackRegular()
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 10.0.w),
                            CategoryTag(productModel: widget.productModel),
                          ],
                        ),
                        SizedBox(height: 10.0.h),
                        Text(
                          S.of(context).similarProducts,
                          style: AppTextStyle.textStyleFont14BlackRegular()
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        ProductsGridWidget(
                          errorState: GetSimilarProductsError(),
                          loadingState: GetSimilarProductsLoading(),
                          type: ProductsType.SIMILAR_PRODUCTS,
                          isScrollable: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Theme.of(context).cardColor,
              child: Padding(
                padding: EdgeInsets.all(10.0.r),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          S.of(context).price,
                          style: AppTextStyle.textStyleFont18BlackBold(),
                        ),
                        Text(
                          "${widget.productModel.price} ${S.of(context).egp}",
                          style: AppTextStyle.textStyleFont18BlackBold()
                              .copyWith(
                            color: AppColors.kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10.0.w),
                    Expanded(
                      child: AppButton(text: "${S.of(context).checkout}>", onPressed: () {}),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryTag extends StatelessWidget {
  const CategoryTag({super.key, required this.productModel});

  final ProductEntity productModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ProductCubit>().getCategoryProducts(
          productModel.category!.id!,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => CategoryProductsPage(),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: AppColors.kPrimaryColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 8.r,
              backgroundImage: CachedNetworkImageProvider(
                productModel.category!.image!,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              productModel.category!.name!,
              style: AppTextStyle.textStyleFont12BlackRegular().copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
