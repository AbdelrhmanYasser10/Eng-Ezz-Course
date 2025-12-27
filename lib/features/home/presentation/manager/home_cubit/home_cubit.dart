import 'package:bloc/bloc.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/entities/user_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/use_cases/get_user_data.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetUserDataUseCase getUserDataUseCase;
  HomeCubit({
    required this.getUserDataUseCase,
}) : super(HomeInitial());
  
  UserEntity? currentUser; // variable
  void getUserData()async{
    emit(GetUserDataLoading());
    final response = await getUserDataUseCase();
    response.fold(
      (l) => emit(GetUserDataError()),
      (r) {
        currentUser = r;
        emit(GetUserDataSuccessfully());
      },
    );
  }
  
  

}
