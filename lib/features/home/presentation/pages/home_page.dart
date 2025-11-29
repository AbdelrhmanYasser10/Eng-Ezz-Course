import 'package:e_commerce_app_session_it_sharks/core/widgets/loading_widget.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getUserData(),
      child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetUserDataLoading) {
              return Scaffold(body: LoadingWidget());
            }
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu)),
                title: Image.asset(
                    "assets/logo/logoipsum-255 1.png",
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
                centerTitle: true,
                actions: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(
                      context.read<HomeCubit>().currentUser!.avatar!,
                    ),
                  ),
                ],
              ),
              body: Center(
                child: Text(
                  context.read<HomeCubit>().currentUser!.email.toString(),
                ),
              ),
            );
          },
        ),
    );
  }
}
