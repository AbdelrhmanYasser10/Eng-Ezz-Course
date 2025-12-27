import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/local/secure_storage_helper.dart';

abstract class HomeLocalDataSource {
  Future<String> getAccessToken();
}

class HomeLocalDataSourceWithSecureStorage implements HomeLocalDataSource {
  final SecureStorageHelper secureStorageHelper;
  const HomeLocalDataSourceWithSecureStorage({
    required this.secureStorageHelper,
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
}
