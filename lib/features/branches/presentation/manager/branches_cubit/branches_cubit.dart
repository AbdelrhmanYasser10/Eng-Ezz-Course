import 'package:bloc/bloc.dart';
import 'package:e_commerce_app_session_it_sharks/features/branches/data/models/location_model.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';

import '../../../../../core/network/remote/dio_helper.dart';

part 'branches_state.dart';

class BranchesCubit extends Cubit<BranchesState> {
  BranchesCubit() : super(BranchesInitial());


  LatLng location = LatLng(51.509865,-0.118092); //Default
  List<LocationModel> allLocations = [];
  final MapController controller = MapController();

  void getUserCurrentLocation()async{
    emit(GetLocationLoading());
    LocationPermission permission = await Geolocator.requestPermission();
    if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
      emit(GetDefaultLocation());
    }
    else{
      Position userPosition = await Geolocator.getCurrentPosition();
      location = LatLng(userPosition.latitude, userPosition.longitude);
      emit(GetCurrentLocation());
    }
  }

  void getAllLocations()async{
    emit(GetAllLocationsLoading());
    try {
      final response = await DioHelper.getData(endPoint: "/locations");
      allLocations = response.data.map<LocationModel>(
            (element) => LocationModel.fromJson(element),
      ).toList();
      emit(GetAllLocationSuccessfully());
    }catch(err){
      emit(GetAllLocationsError());
    }
  }

  void updateMyLocation(){
    controller.move(location, 9.2);
    emit(UpdateMyLocation());
  }

}
