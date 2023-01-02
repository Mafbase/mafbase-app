import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/data/http_client.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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
  final Map<Type, StreamSubscription> _subscriptions = {};
  final Map<Type, EffectHandler> map = {};

  @override
  void initState() {
    super.initState();
    registerEffectHandlers(
      <T>(handler) {
        _subscriptions[T]?.cancel();
        _subscriptions[T] = context
            .read<B>()
            .effectsStream
            .where((event) => event is T)
            .listen((event) {
          map[T]?.call(event as T);
        });
        map[T] = (effect) => handler(effect);
      },
    );
  }

  @override
  void dispose() {
    for (final subscription in _subscriptions.values) {
      subscription.cancel();
    }
    super.dispose();
  }

  void registerEffectHandlers(Function<T>(EffectHandler<T> handler) on) {}
}

abstract class CustomBloc<E, S> extends Bloc<E, S> {
  final BuildContext? context;

  CustomBloc(super.initialState, [this.context]);

  @override
  void on<EV extends E>(
    EventHandler<EV, S> handler, {
    EventTransformer<EV>? transformer,
  }) {
    super.on(
      (event, emit) async {
        await _functionWrapper(
          () async {
            await handler(event, emit);
          },
          emit,
        );
      },
      transformer: transformer,
    );
  }

  void emitOnError(Emitter<S> emit);

  FutureOr _functionWrapper(
    FutureOr Function() function,
    Emitter<S> emit,
  ) async {
    try {
      try {
        return await function();
      } on RequestError catch (error) {
        if (context != null) {
          AppRouter.showErrorDialog(context!, error.message ?? "");
        }
        rethrow;
      } on UnauthenticatedError catch (error) {
        if (context != null) {
          final location = GoRouter.of(context!).location;
          context!.go(AppRoutes.loginPageRoute, extra: location);
          AppRouter.showErrorDialog(context!, error.message ?? "");
        }
        rethrow;
      } catch (error) {
        if (context != null) {
          AppRouter.showErrorDialog(context!, "Произошла неизвестная ошибка");
        }
        rethrow;
      }
    } catch (ignored, stacktrace) {
      emitOnError(emit);
      Sentry.captureException(ignored, stackTrace: stacktrace);
    }
  }
}
