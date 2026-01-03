import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/local/secure_storage_helper.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/local/shared_preferences_helper.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/data/data_sources/auth_local_data_source.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/data/repositories/authentication_repository_implementer.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/use_cases/login_with_email_and_password.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/use_cases/register_user_data.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/data/data_sources/remote_data_source.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/repositories/chat_repository.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/use_cases/getAllMessages.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/use_cases/get_all_users.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/use_cases/send_message.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/presentation/manager/chats_cubit/chats_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/data/data_sources/loca_data_source.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/data/data_sources/remote_data_source.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/data/repositories/home_repository_impl.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/repositories/home_repository.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/use_cases/get_all_categories_use_case.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/use_cases/get_all_products_use_case.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/use_cases/get_category_products_use_case.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/use_cases/get_user_data.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/use_cases/search_for_product.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/manager/categories_cubit/categories_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/manager/product_cubit/product_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/manager/search_cubit/search_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/features/splash/data/data_sources/splash_local_data_source.dart';
import 'package:e_commerce_app_session_it_sharks/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:e_commerce_app_session_it_sharks/features/splash/domain/repositories/splash_repository.dart';
import 'package:e_commerce_app_session_it_sharks/features/splash/domain/use_cases/get_access_token_use_case.dart';
import 'package:e_commerce_app_session_it_sharks/features/splash/domain/use_cases/is_passed_on_boarding_use_case.dart';
import 'package:e_commerce_app_session_it_sharks/features/splash/domain/use_cases/pass_onboarding_use_case.dart';
import 'package:e_commerce_app_session_it_sharks/features/splash/presentation/manager/splash_cubit/splash_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/remote/dio_helper.dart';

import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/use_cases/upload_image_use_case.dart';

import 'features/chats/data/repositories/chat_repository_impl.dart';

final sl = GetIt.instance;

Future<void> initialize() async {
  // Feature Manager ==> Cubits
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginUseCase: sl(),
      registerUseCase: sl(),
      uploadImageUseCase: sl(),
    ),
  );

  sl.registerFactory<SplashCubit>(
    () => SplashCubit(
      getAccessTokenUseCase: sl(),
      isPassedOnBoardingUseCase: sl(),
      passOnBoardingUseCase: sl(),
    ),
  );
  sl.registerFactory<HomeCubit>(() => HomeCubit(getUserDataUseCase: sl()));
  sl.registerFactory<ProductCubit>(
    () => ProductCubit(
      getAllProductsUseCase: sl(),
      getCategoryProductsUseCase: sl(),
    ),
  );
  sl.registerFactory<CategoriesCubit>(
    () => CategoriesCubit(getAllCategoriesUseCase: sl()),
  );
  sl.registerFactory<SearchCubit>(() => SearchCubit(searchForProduct: sl()));

  sl.registerFactory<ChatsCubit>(
    () => ChatsCubit(getAllUsers: sl(), sendMessage: sl(),getAllMessages: sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImplementer(
      authRemoteDataSource: sl(),
      authLocalDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<SplashRepository>(
    () => SplashRepositoryImpl(splashLocalDataSource: sl()),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(
      chatFirebaseDataSource: sl(),
      chatApiDataSource: sl(),
    ),
  );
  // Use Cases
  sl.registerLazySingleton<LoginWithEmailAndPassword>(
    () => LoginWithEmailAndPassword(repository: sl()),
  );
  sl.registerLazySingleton<RegisterUserData>(
    () => RegisterUserData(repository: sl()),
  );
  sl.registerLazySingleton<UploadImageUseCase>(
    () => UploadImageUseCase(repository: sl()),
  );

  sl.registerLazySingleton<GetAccessTokenUseCase>(
    () => GetAccessTokenUseCase(sl()),
  );
  sl.registerLazySingleton<IsPassedOnBoardingUseCase>(
    () => IsPassedOnBoardingUseCase(repository: sl()),
  );
  sl.registerLazySingleton<PassOnBoardingUseCase>(
    () => PassOnBoardingUseCase(sl()),
  );

  sl.registerLazySingleton<GetUserDataUseCase>(
    () => GetUserDataUseCase(repository: sl()),
  );
  sl.registerLazySingleton<GetAllProductsUseCase>(
    () => GetAllProductsUseCase(sl()),
  );
  sl.registerLazySingleton<GetAllCategoriesUseCase>(
    () => GetAllCategoriesUseCase(sl()),
  );
  sl.registerLazySingleton<GetCategoryProductsUseCase>(
    () => GetCategoryProductsUseCase(sl()),
  );

  sl.registerLazySingleton<SearchForProduct>(() => SearchForProduct(sl()));

  sl.registerLazySingleton<SendMessage>(() => SendMessage(sl()));
  sl.registerLazySingleton<GetAllUsers>(() => GetAllUsers(sl()));
  sl.registerLazySingleton<GetAllMessages>(() => GetAllMessages(sl()));
  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceWithDio(dio: sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImplWithSecureStorage(secureStorageHelper: sl()),
  );

  sl.registerLazySingleton<SplashLocalDataSource>(
    () => SplashLocalDataSourceImplWithSPAndSecureStorage(
      secureStorageHelper: sl(),
      sharedPreferencesHelper: sl(),
    ),
  );

  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceWithDio(sl()),
  );
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceWithSecureStorage(secureStorageHelper: sl()),
  );

  sl.registerLazySingleton<ChatApiDataSource>(
    () => ChatApiDataSourceImplWithDio(sl()),
  );
  sl.registerLazySingleton<ChatFirebaseDataSource>(
    () => ChatFirebaseDataSourceImpl(sl()),
  );

  // Source
  sl.registerLazySingleton(() => DioHelper());
  sl.registerLazySingleton(() => SecureStorageHelper());
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  final preference = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => SharedPreferencesHelper(preference));
}
