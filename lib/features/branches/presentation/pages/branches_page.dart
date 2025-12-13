import 'package:e_commerce_app_session_it_sharks/core/styles/app_text_style.dart';
import 'package:e_commerce_app_session_it_sharks/core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/styles/app_colors.dart';
import '../manager/branches_cubit/branches_cubit.dart';

class BranchesPage extends StatelessWidget {
  const BranchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BranchesCubit>(
      create:
          (_) =>
              BranchesCubit()
                ..getUserCurrentLocation()
                ..getAllLocations(),
      child: Scaffold(
        floatingActionButton: BlocConsumer<BranchesCubit, BranchesState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = context.read<BranchesCubit>();
            return FloatingActionButton(
              onPressed: () {
                cubit.updateMyLocation();
              },
              backgroundColor: AppColors.kPrimaryColor,
              child: Icon(Icons.my_location, color: Colors.white),
            );
          },
        ),
        body: BlocConsumer<BranchesCubit, BranchesState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetLocationLoading ||
                state is GetAllLocationsLoading) {
              return LoadingWidget();
            }
            var locationsList = context.read<BranchesCubit>().allLocations;
            return FlutterMap(
              mapController: context.read<BranchesCubit>().controller,
              options: MapOptions(
                initialCenter:
                    context
                        .read<BranchesCubit>()
                        .location, // Center the map over London
                initialZoom: 9.2,
              ),
              children: [
                TileLayer(
                  // Bring your own tiles
                  urlTemplate:
                      'https://api.maptiler.com/maps/outdoor-v4/{z}/{x}/{y}.png?key=WB1imKRisyiBa9agZNux',
                  // For demonstration only
                  userAgentPackageName:
                      'com.example.e_commerce_app_session_it_sharks', // Add your app identifier
                  // And many more recommended properties!
                ),
                locationsList.isNotEmpty
                    ? MarkerLayer(
                      markers:
                          locationsList.map<Marker>((element) {
                            return Marker(
                              point: LatLng(
                                element.latitude!,
                                element.longitude!,
                              ),
                              child: Wrap(
                                children: [
                                  Text(
                                    element.name.toString(),
                                    style:
                                        AppTextStyle.textStyleFont12BlackRegular()
                                            .copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 45,
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                    )
                    : const SizedBox.shrink(),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: context.read<BranchesCubit>().location,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(Icons.my_location, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
