import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../manager/product_cubit/product_cubit.dart';
import '../widgets/product_card.dart';

class CategoryProductsPage extends StatelessWidget {
  const CategoryProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if(state is GetCategoryProductsLoading){
            return const LoadingWidget();
          }
          else if(state is GetCategoryProductsError) {
            return Text("err");
          }
          else{
            log("Error here");

            var cubit = context.read<ProductCubit>();
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1/1.8
              ),
              itemCount: cubit.categoryProducts.length,
              itemBuilder: (context, index) {
                var currProduct = cubit.categoryProducts[index];
                return ProductCard(
                  productModel: currProduct,
                );
              },
            );
          }
        },
      ),
    );
  }
}
