import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
