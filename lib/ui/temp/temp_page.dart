import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/flip_widget.dart';
import 'package:seating_generator_web/ui/temp/temp_bloc.dart';
import 'package:seating_generator_web/ui/temp/temp_event.dart';
import 'package:seating_generator_web/ui/temp/temp_state.dart';

class TempPage extends StatefulWidget {
  const TempPage({super.key});

  static const String name = 'temp';
  static final GoRoute route = GoRoute(
    path: '/temp',
    name: name,
    builder: (context, state) {
      return BlocProvider<TempBloc>(
        create: (context) => TempBloc(),
        child: const TempPage(),
      );
    },
  );

  @override
  State<TempPage> createState() => _TempPageState();
}

class _TempPageState extends State<TempPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TempBloc, TempState>(
      builder: (context, state) {
        final Widget child;
        switch (state.style) {
          case TempStyle.hide:
            child = Container(
              padding: const EdgeInsets.all(8),
              child: const Text("Испытай удачу!"),
            );
            break;
          case TempStyle.empty:
            child = Container(
              padding: const EdgeInsets.all(8),
              child: const Text("Попробуй в следующий раз"),
            );
            break;
          case TempStyle.classic:
            child = Container(
              color: Colors.blueAccent,
              padding: const EdgeInsets.all(8),
              child: const Text("Ты получил карточку!"),
            );
            break;
          case TempStyle.gold:
            child = Container(
              color: Colors.amber,
              padding: const EdgeInsets.all(8),
              child: const Text("Ты получил ЗОЛОТУЮ карточку!"),
            );
            break;
        }
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: FlipWidget(
              child: Container(
                key: Key(state.style.name),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      offset: const Offset(2, 2),
                      spreadRadius: 3,
                      blurRadius: 5,
                    ),
                  ],
                ),
                height: 400,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    child,
                    CustomButton(
                      text: "Дальше",
                      onTap: () {
                        context
                            .read<TempBloc>()
                            .add(const TempEvent.generate());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
