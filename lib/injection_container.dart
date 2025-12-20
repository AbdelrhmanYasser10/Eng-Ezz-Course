import 'package:e_commerce_app_session_it_sharks/core/network/local/secure_storage_helper.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/local/shared_preferences_helper.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/data/data_sources/auth_local_data_source.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/data/repositories/authentication_repository_implementer.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/use_cases/login_with_email_and_password.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/use_cases/register_user_data.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/remote/dio_helper.dart';

import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/use_cases/upload_image_use_case.dart';

final sl = GetIt.instance;


Future<void> initialize () async{
  // Feature Manager ==> Cubits
  sl.registerFactory<AuthCubit>(
      ()=>AuthCubit(
          loginUseCase: sl(),
          registerUseCase: sl(),
          uploadImageUseCase: sl(),
      ),
  );

  // Repository
  sl.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImplementer(authRemoteDataSource: sl(),authLocalDataSource: sl()),);

  // Use Cases
  sl.registerLazySingleton<LoginWithEmailAndPassword>(()=> LoginWithEmailAndPassword(repository: sl()));
  sl.registerLazySingleton<RegisterUserData>(()=> RegisterUserData(repository: sl()));
  sl.registerLazySingleton<UploadImageUseCase>(()=> UploadImageUseCase(repository: sl()));

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(()=>AuthRemoteDataSourceWithDio(dio: sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(()=>AuthLocalDataSourceImplWithSecureStorage(secureStorageHelper: sl()));

  // Source
  sl.registerLazySingleton(()=>DioHelper());
  sl.registerLazySingleton(()=>SecureStorageHelper());

  final preference = await SharedPreferences.getInstance();
  sl.registerLazySingleton(()=>SharedPreferencesHelper(preference));

}