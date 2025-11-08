import 'package:e_commerce_app_session_it_sharks/logic/counter_cubit/counter_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/view/decrement_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class IncrementScreen extends StatelessWidget {
  const IncrementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CounterCubit, CounterState>(
      listener: (context, state) {
        print(state);
      },
      builder: (context, state) {
        CounterCubit cubit = BlocProvider.of<CounterCubit>(context); // instance of business logic object
        return Scaffold(
          appBar: AppBar(
            title: Text("Increment Screen"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(
                    "I am in increment screen:"
                ),
                Text(
                    "${cubit.counter}"
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DecrementScreen(),
                          ),
                        );
                      },
                      child: Text(
                          "Go to Decrement Screen"
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                          cubit.increment();
                      },
                      child: Text(
                          "+"
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
