import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app_session_it_sharks/core/components/app_button.dart';
import 'package:e_commerce_app_session_it_sharks/core/styles/app_text_style.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:see_more_text/see_more_text.dart';

import '../../../../core/styles/app_colors.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductModel productModel;
  const ProductDetailsPage({super.key, required this.productModel});

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
                items: productModel.images!.map((element){
                  return CachedNetworkImage(
                      imageUrl: element,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 220,
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

              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        productModel.title!,
                      style: AppTextStyle.textStyleFont20BlackBold(),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Product Details",
                      style: AppTextStyle.textStyleFont14BlackRegular().copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    SeeMoreText(
                      text: productModel.description!,
                      maxLines: 3,
                      textStyle: AppTextStyle.textStyleFont12BlackRegular().copyWith(),
                      linkStyle: TextStyle(
                        color:AppColors.kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      seeMoreText: 'Read more',
                      seeLessText: 'Show less',
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Text(
                          "Categories",
                          style: AppTextStyle.textStyleFont14BlackRegular().copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.kPrimaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 8,
                                backgroundImage: CachedNetworkImageProvider(
                                  productModel.category!.image!,
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                productModel.category!.name!,
                                style: AppTextStyle.textStyleFont12BlackRegular().copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize:MainAxisSize.min,
                      children: [
                        Text(
                          "Price",
                          style: AppTextStyle.textStyleFont18BlackBold(),
                        ),
                        Text(
                          "100 EGP",
                          style: AppTextStyle.textStyleFont18BlackBold().copyWith(
                            color: AppColors.kPrimaryColor
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(child: AppButton(text: "Checkout>", onPressed: (){})),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
}
