import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/remote/dio_helper.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/data/models/category_model.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/data/models/product_model.dart' hide CategoryModel;
import 'package:e_commerce_app_session_it_sharks/features/home/data/models/user_model.dart';

abstract class HomeRemoteDataSource {
  Future<UserModel> getUserData(String accessToken);

  Future<List<ProductModel>> getAllProducts();

  Future<List<CategoryModel>> getAllCategories();

  Future<List<ProductModel>> getCategoryProducts(int categoryId);

  Future<List<ProductModel>> searchedProducts(String productName);
}

class HomeRemoteDataSourceWithDio implements HomeRemoteDataSource {
  final DioHelper dioHelper;
  const HomeRemoteDataSourceWithDio(this.dioHelper);

  @override
  Future<UserModel> getUserData(String accessToken) async {
    try {
      final response = await dioHelper.getData(
        endPoint: "/auth/profile",
        accessToken: accessToken,
      );
      final user = UserModel.fromJson(response.data);
      return user;
    } catch (err) {
      throw (ServerFailure(message: "Error, while getting user data"));
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await dioHelper.getData(endPoint: "/products");
      return (response.data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } catch (err) {
      throw (ServerFailure(message: "Error, while getting products"));
    }
  }

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final response = await dioHelper.getData(endPoint: "/categories");
      return (response.data as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList();
    } catch (err) {
      throw (ServerFailure(message: "Error, while getting categories"));
    }
  }

  @override
  Future<List<ProductModel>> getCategoryProducts(int categoryId) async {
    try {
      final response = await dioHelper.getData(
        endPoint: "/products",
        queryParameters: {"categoryId": categoryId},
      );
      return (response.data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } catch (err) {
      throw (ServerFailure(message: "Error, while getting category products"));
    }
  }

  @override
  Future<List<ProductModel>> searchedProducts(String productName) async{
    try {
      final response = await dioHelper.getData(
        endPoint: "/products",
        queryParameters: {"title": productName},
      );
      return (response.data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } catch (err) {
      throw (ServerFailure(message: "Error, while getting category products"));
    }
  }
}
