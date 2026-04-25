import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/feature/payment_waiting/ui/payment_waiting_bloc.dart';
import 'package:seating_generator_web/feature/payment_waiting/ui/payment_waiting_effect.dart';
import 'package:seating_generator_web/feature/payment_waiting/ui/payment_waiting_event.dart';
import 'package:seating_generator_web/feature/payment_waiting/ui/payment_waiting_state.dart';
import 'package:seating_generator_web/utils.dart';

@RoutePage()
class PaymentWaitingPage extends StatelessWidget {
  const PaymentWaitingPage({
    @QueryParam('purchaseId') this.purchaseId,
    @QueryParam('nextPath') this.nextPath,
    super.key,
  });

  final int? purchaseId;
  final String? nextPath;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentWaitingBloc>(
      create: (context) {
        final bloc = PaymentWaitingBloc(
          RepositoryFactory.of(context).paymentWaitingRepository,
        );
        final id = purchaseId;
        if (id != null) {
          bloc.add(PaymentWaitingEvent.start(
            purchaseId: id,
            nextPath: nextPath ?? '/',
          ),);
        }
        return bloc;
      },
      child: PaymentWaitingView(nextPath: nextPath),
    );
  }
}

class PaymentWaitingView extends StatefulWidget {
  const PaymentWaitingView({super.key, this.nextPath});

  final String? nextPath;

  @override
  State<PaymentWaitingView> createState() => _PaymentWaitingViewState();
}

class _PaymentWaitingViewState extends State<PaymentWaitingView>
    with EffectListener<PaymentWaitingEffect, PaymentWaitingState, PaymentWaitingBloc, PaymentWaitingView> {
  @override
  void registerEffectHandlers(Function<T>(EffectHandler<T> handler) on) {
    on<PaymentWaitingEffectNavigateNext>((effect) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.locale.paymentWaitingSuccessSnackbar)),
      );
      context.router.navigatePath(effect.nextPath);
    });
    on<PaymentWaitingEffectPaymentCanceled>((effect) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.locale.paymentWaitingCanceledSnackbar)),
      );
      context.router.navigatePath(effect.nextPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.locale.paymentWaitingTitle),
        leading: BackButton(
          onPressed: () => context.router.navigatePath(widget.nextPath ?? '/'),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 24),
              Text(
                context.locale.paymentWaitingMessage,
                style: theme.defaultTextStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
