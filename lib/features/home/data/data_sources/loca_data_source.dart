import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/local/secure_storage_helper.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/local/shared_preferences_helper.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/data/models/product_model.dart';

abstract class HomeLocalDataSource {
  Future<String> getAccessToken();
  Future<void> saveProductInFavourite(ProductModel product);
  Future<List<ProductModel>> getFavourites();
}

class HomeLocalDataSourceWithSecureStorage implements HomeLocalDataSource {
  final SecureStorageHelper secureStorageHelper;
  final SharedPreferencesHelper sharedPreferencesHelper;
  const HomeLocalDataSourceWithSecureStorage({
    required this.secureStorageHelper,
    required this.sharedPreferencesHelper,
  });

  @override
  Future<String> getAccessToken() async {
    try {
      final accessToken = await secureStorageHelper.getData(key: "accessToken");
      return accessToken!;
    } catch (err) {
      throw EmptyCacheFailure(message: "There's no access token");
    }
  }

  @override
  Future<List<ProductModel>> getFavourites() async{
    try {
      List<ProductModel> savedProducts = [];
      if(sharedPreferencesHelper
          .getDataFromCache(key: "fav")!=null) {
        savedProducts = sharedPreferencesHelper
          .getDataFromCache(key: "fav").map<ProductModel>((element) =>
          ProductModel.fromJson(jsonDecode(element))).toList();
      }
      return savedProducts;
    }catch(err){
      throw EmptyCacheFailure(message: "cannot get this data");
    }
  }

  @override
  Future<void> saveProductInFavourite(ProductModel product) async{
    try {
      List<ProductModel> savedProducts = [];
      if(sharedPreferencesHelper
          .getDataFromCache(key: "fav") != null) {
        savedProducts = sharedPreferencesHelper
            .getDataFromCache(key: "fav").map<ProductModel>((element) =>
            ProductModel.fromJson(jsonDecode(element))).toList();
        if (savedProducts.contains(product)) {
          savedProducts.remove(product);
        }
        else {
          savedProducts.add(product);
        }
      }
      else{
        savedProducts.add(product);
      }

      await sharedPreferencesHelper.writeDataToCache(key: "fav",
        value: savedProducts.map<String>((element) =>
            jsonEncode(element.toJson())).toList(),
      );
    }catch(err){
      throw EmptyCacheFailure(message: "cannot cache this data");
    }
  }
}
