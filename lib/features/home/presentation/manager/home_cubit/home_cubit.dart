import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/local/secure_storage_helper.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/remote/dio_helper.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/data/models/user_model.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  
  UserModel? currentUser;
  void getUserData()async{
    emit(GetUserDataLoading());
    
    try{
      var accessToken = await SecureStorageHelper.getData(key: "accessToken");
      Response response = await DioHelper.getData(endPoint: "/auth/profile", accessToken: accessToken);
      if(response.statusCode == 200){
        currentUser = UserModel.fromJson(response.data);
        emit(GetUserDataSuccessfully());
      }
      else{
        emit(GetUserDataError());
      }
    }
    catch(err){
      emit(GetUserDataError());
    }
    
  }
  
}
