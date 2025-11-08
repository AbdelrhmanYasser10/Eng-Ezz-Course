import 'package:e_commerce_app_session_it_sharks/logic/counter_cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DecrementScreen extends StatelessWidget {
  const DecrementScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CounterCubit, CounterState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        CounterCubit cubit = BlocProvider.of<CounterCubit>(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("Decrement Screen"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(
                    "I am in Decrement Screen:"
                ),
                Text(
                    "${cubit.counter}"
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                          "Go to Back"
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        cubit.decrement();
                      },
                      child: Text(
                          "-"
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
