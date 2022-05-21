import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/pots_actor/pots_bloc.dart';

class CreatePotSetBody extends StatefulWidget {
  CreatePotSetBody({Key? key}) : super(key: key);

  @override
  State<CreatePotSetBody> createState() => _CreatePotSetBodyState();
}

class _CreatePotSetBodyState extends State<CreatePotSetBody> {
  final _incomeController = TextEditingController();
  final _nameController = TextEditingController();
  final _incomeAmountFocusNode = FocusNode();

  String _previousIncomeValue = '';
  String _previousNameValue = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<PotsBloc, PotsState>(
      listener: (context, state) => _stateHandler(context, state),
      child: Scaffold(
        body: Stack(
          children: [],
        ),
      ),
    );
  }

  void _stateHandler(BuildContext context, PotsState state) {
    if (state is PercentOrAmountInputErrorState) {
      _incomeController.text = _previousIncomeValue;
      _nameController.text = _previousNameValue;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(state.message),
          action: SnackBarAction(
            label: 'ОК',
            onPressed: () {},
          ),
        ),
      );
      BlocProvider.of<PotsBloc>(context)
          .add(const UserIsFixingInputErrorEvent());
    }
    if (state is PotsChangedSuccesfullyState) {
      FocusManager.instance.primaryFocus?.unfocus();
      Navigator.of(context).pop();
    }
  }
}
