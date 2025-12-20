import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/network/remote/dio_helper.dart';
import '../../../data/models/category_model.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());
  void getAllCategories() async{
    emit(GetAllCategoriesLoading());
    try {
/*
      final response = await DioHelper.getData(endPoint: "/categories");
*/
      List<CategoryModel> allCategories = [];
      /*response.data.forEach((element){
      allCategories.add(CategoryModel.fromJson(element));
    });*/
      /*for(var element in response.data){
      allCategories.add(CategoryModel.fromJson(element));
    }*/

     /* allCategories =
          response.data.map<CategoryModel>((element) => CategoryModel.fromJson(element))
              .toList();*/
      emit(GetAllCategoriesSuccessfully(allCategoreies: allCategories));
    }catch(err){
      log(err.toString());
      emit(GetAllCategoriesError());
    }
  }

}
