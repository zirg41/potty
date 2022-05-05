import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potty/dependency_injection.dart';
import 'package:potty/features/potties_manager/presentation/bloc/pots_bloc.dart';

class PotSetsPage extends StatelessWidget {
  const PotSetsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your pots")),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => sl<PotsBloc>(),
          child: Container(),
        ),
      ),
    );
  }
}
