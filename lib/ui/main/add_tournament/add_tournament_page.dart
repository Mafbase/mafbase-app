import 'package:flutter/material.dart';

class AddTournamentPage extends StatefulWidget {
  const AddTournamentPage({super.key});

  @override
  State<AddTournamentPage> createState() => _AddTournamentPageState();
}

class _AddTournamentPageState extends State<AddTournamentPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: const Center(
        child: Text("AddTournamentPage"),
      ),
    );
  }
}
