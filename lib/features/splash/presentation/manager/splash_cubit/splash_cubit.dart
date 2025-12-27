import 'package:bloc/bloc.dart';
import 'package:e_commerce_app_session_it_sharks/features/splash/domain/use_cases/get_access_token_use_case.dart';
import 'package:e_commerce_app_session_it_sharks/features/splash/domain/use_cases/is_passed_on_boarding_use_case.dart';
import 'package:e_commerce_app_session_it_sharks/features/splash/domain/use_cases/pass_onboarding_use_case.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final GetAccessTokenUseCase getAccessTokenUseCase;
  final PassOnBoardingUseCase passOnBoardingUseCase;
  final IsPassedOnBoardingUseCase isPassedOnBoardingUseCase;
  SplashCubit({
    required this.isPassedOnBoardingUseCase,
    required this.passOnBoardingUseCase,
    required this.getAccessTokenUseCase,
}) : super(SplashInitial());


  void getAccessToken()async{
    final result = await getAccessTokenUseCase();
    result.fold(
      (l){
        if(l == null){
          emit(GetAccessTokenError());
        }
        else{
          emit(GetAccessTokenSuccessfully());
        }
      },
    (r) => emit(GetAccessTokenError()),
    );
  }


  void isPassedOnBoarding()async{
    final result = await isPassedOnBoardingUseCase();
    result.fold(
          (l){
        if(l == null){
          emit(PassOnBoardingError());
        }
        else{
          emit(PassOnBoardingSuccessFully());
        }
      },
      (r) => emit(PassOnBoardingError()),
    );
  }

  void saveOnBoardingValue(bool pass)async{
    final result = await passOnBoardingUseCase(pass);
    result.fold(
          (l){
        emit(SaveOnBoardingSuccessfully());
            },
      (r) => emit(SaveOnBoardingError()),
    );
  }


}
