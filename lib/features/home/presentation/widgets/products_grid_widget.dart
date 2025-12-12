import 'package:e_commerce_app_session_it_sharks/features/home/data/models/product_model.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../manager/product_cubit/product_cubit.dart';

enum ProductsType{
  SIMILAR_PRODUCTS,
  HOME_PRODUCTS,
  CATEGORY_PRODUCTS,
}

class ProductsGridWidget extends StatelessWidget {
  final ProductState loadingState;
  final ProductState errorState;
  final bool isScrollable;
  final ProductsType type;
  const ProductsGridWidget({
    super.key,
    required this.loadingState,
    required this.errorState,
    required this.isScrollable,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (loadingState.runtimeType == state.runtimeType) {
          return const LoadingWidget();
        } else if (errorState.runtimeType == state.runtimeType) {
          return Text("err");
        } else {
          return GridView.builder(
            physics: isScrollable ? const BouncingScrollPhysics():const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.8,
            ),
            itemCount: _getProductList(context).length,
            itemBuilder: (context, index) {
              var currProduct = _getProductList(context)[index];
              return ProductCard(productModel: currProduct);
            },
          );
        }
      },
    );
  }

  List<ProductModel> _getProductList(BuildContext context){
    switch(type){
      case ProductsType.SIMILAR_PRODUCTS:
        return context.read<ProductCubit>().similarProducts;
      case ProductsType.CATEGORY_PRODUCTS:
        return context.read<ProductCubit>().categoryProducts;
      case ProductsType.HOME_PRODUCTS:
        return context.read<ProductCubit>().homeProducts;
      }
  }
}
