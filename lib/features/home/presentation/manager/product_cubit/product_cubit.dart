import 'package:bloc/bloc.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/remote/dio_helper.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/data/models/product_model.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  List<ProductModel> homeProducts = [];
  List<ProductModel> categoryProducts = [];

  void getAllProducts() async {
    emit(GetAllProductsLoading());
    try {
      final response = await DioHelper.getData(endPoint: "/products");
      List<ProductModel> allProducts =
          response.data
              .map<ProductModel>((element) => ProductModel.fromJson(element))
              .toList();
      homeProducts = allProducts;
      emit(GetAllProductsSuccessfully());
    } catch (err) {
      emit(GetAllProductsError());
    }
  }

  void getCategoryProducts(int categoryId) async {
    emit(GetCategoryProductsLoading());
    try {
      final response = await DioHelper.getData(
        endPoint: "/products",
        queryParameters: {"categoryId": categoryId},
      );
      List<ProductModel> allProducts =
          response.data
              .map<ProductModel>((element) => ProductModel.fromJson(element))
              .toList();
      categoryProducts = allProducts;
      emit(GetCategoryProductsSuccessfully());
    } catch (err) {
      emit(GetCategoryProductsError());
    }
  }
}
