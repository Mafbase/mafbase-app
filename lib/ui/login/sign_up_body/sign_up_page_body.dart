import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/ui/login/sign_up_body/sign_up_bloc.dart';
import 'package:seating_generator_web/ui/login/sign_up_body/sign_up_events.dart';
import 'package:seating_generator_web/ui/login/sign_up_body/sign_up_state.dart';

class SignUpPageBody extends StatefulWidget {
  const SignUpPageBody({Key? key}) : super(key: key);

  @override
  _SignUpPageBodyState createState() => _SignUpPageBodyState();
}

class _SignUpPageBodyState extends State<SignUpPageBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Stack(
          children: [
            Positioned(
              child: IconButton(
                onPressed: _onBackButtonTapped,
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
            Column(
              children: [],
            ),
          ],
        );
      },
    );
  }
  _onBackButtonTapped() {
    context.read<SignUpBloc>().add(const SignUpEvents.backButtonTapped());
  }
}
