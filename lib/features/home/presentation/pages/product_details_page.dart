import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/data/models/product_model.dart';
import 'package:flutter/material.dart';


class ProductDetailsPage extends StatelessWidget {
  final ProductModel productModel;
  const ProductDetailsPage({super.key , required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CachedNetworkImage(imageUrl: productModel.images![0]),
            Text(
              productModel.title!
            ),
            Text(
              productModel.description!
            ),
            Text(
              "${productModel.price!} EGP"
            ),
            Text(
              productModel.slug!
            ),

          ],
        ),
      ),
    );
  }
}
