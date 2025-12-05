import 'package:bloc/bloc.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/remote/dio_helper.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/data/models/product_model.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());



  void getAllProducts()async{
    emit(GetAllProductsLoading());
    try {
      final response = await DioHelper.getData(endPoint: "/products");
      List<ProductModel> allProducts = response.data.map<ProductModel>((element)=>ProductModel.fromJson(element)).toList();
      emit(GetAllProductsSuccessfully(allProducts: allProducts));
    }catch(err){
      emit(GetAllProductsError());
    }
  }

}
