import 'package:flutter/material.dart';

import '../manager/product_cubit/product_cubit.dart';
import '../widgets/products_grid_widget.dart';

class CategoryProductsPage extends StatelessWidget {
  const CategoryProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  ProductsGridWidget(
        errorState: GetCategoryProductsError(),
        loadingState: GetCategoryProductsLoading(),
        type: ProductsType.CATEGORY_PRODUCTS,
        isScrollable: true,
      ),
    );
  }
}
