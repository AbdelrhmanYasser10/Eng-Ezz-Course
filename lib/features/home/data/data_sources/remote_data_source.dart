import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/remote/dio_helper.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/data/models/user_model.dart';

abstract class HomeRemoteDataSource {
  Future<UserModel> getUserData(String accessToken);
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
      throw (ServerFailure(message: "Error, while getting data"));
    }
  }
}
