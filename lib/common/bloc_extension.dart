import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/data/http_client.dart';

typedef EffectHandler<E> = void Function(E efffect);

mixin EffectEmitter<E, S> on BlocBase<S> {
  final _effectController = StreamController<E>.broadcast();

  Stream<E> get effectsStream => _effectController.stream;

  @override
  Future<void> close() {
    _effectController.close();
    return super.close();
  }

  void emitEffect(E effect) {
    _effectController.add(effect);
  }
}

mixin EffectListener<E, S, B extends EffectEmitter<E, S>,
    W extends StatefulWidget> on State<W> {
  StreamSubscription? _subscription;
  final Map<Type, EffectHandler> map = {};

  @override
  void initState() {
    super.initState();
    registerEffectHandlers(
      <T>(handler) => map[T] = (effect) => handler(effect),
    );
    _subscription = context.read<B>().effectsStream.listen((event) {
      map[event.runtimeType]?.call(event);
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void registerEffectHandlers(Function<T>(EffectHandler<T> handler) on) {}
}

class CustomBloc<E, S> extends Bloc<E, S> {
  final BuildContext? _context;

  CustomBloc(super.initialState, [this._context]);

  @override
  void on<EV extends E>(EventHandler<EV, S> handler,
      {EventTransformer<EV>? transformer}) {
    super.on(
      (event, emit) async {
        await _functionWrapper(() async {
          await handler(event, emit);
        });
      },
      transformer: transformer,
    );
  }

  FutureOr _functionWrapper(FutureOr Function() function) async {
    try {
      return await function();
    } on RequestError catch (error) {
      if (_context != null) {
        AppRouter.showErrorDialog(_context!, error.message ?? "");
      }
      rethrow;
    } on UnauthenticatedError catch (error) {
      if (_context != null) {
        _context!.go(AppRoutes.loginPageRoute);
        AppRouter.showErrorDialog(_context!, error.message ?? "");
      }
    }
  }
}
