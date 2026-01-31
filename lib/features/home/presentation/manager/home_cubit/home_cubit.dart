import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/remote/message_config.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/entities/user_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/use_cases/get_user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    if(FirebaseAuth.instance.currentUser!=null){
      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({"fcmToken": MessagingConfig.getFCMToken()});
      currentUser = UserEntity(
        id: FirebaseAuth.instance.currentUser!.uid,
        avatar: FirebaseAuth.instance.currentUser!.photoURL ?? "",
        email: FirebaseAuth.instance.currentUser!.email,
        name: FirebaseAuth.instance.currentUser!.displayName,
        fcmToken: MessagingConfig.getFCMToken(),
      );
      emit(GetUserDataSuccessfully());
    }
    else{
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



  

}
