import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprints_counter_app/cubit/counter_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Counter screen'),
      ),
      body: BlocListener<CounterCubit, CounterState>(
        listener: (context, state) {
          if (state.value < 0) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Warning'),
                content: const Text('Counter is negative!'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.value == 10 || state.value == -10) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Counter reached ${state.value}  :)'),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Text(
                  'Counter Value: ${state.value}',
                  style: const TextStyle(fontSize: 24),
                );
              },
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton.filled(
                    onPressed: () {
                      context.read<CounterCubit>().increment();
                    },
                    icon: Icon(Icons.add)),
                IconButton.filled(
                    onPressed: () {
                      context.read<CounterCubit>().decrement();
                    },
                    icon: Icon(Icons.remove)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
