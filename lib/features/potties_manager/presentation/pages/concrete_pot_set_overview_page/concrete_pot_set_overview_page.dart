import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/pots_actor/pots_bloc.dart';
import 'widgets/potset_overview_body.dart';
import 'widgets/potset_appbar.dart';

class ConcretePotSetOverviewPage extends StatelessWidget {
  final String potSetId;

  const ConcretePotSetOverviewPage({
    required this.potSetId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<PotsBloc, PotsState>(
      listener: (context, state) {
        if (state is IncomeInputErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            errorSnackBar(state.message),
          );
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          BlocProvider.of<PotsBloc>(context)
              .add(const PotsChangedSuccesfullyEvent());
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            title: PotSetAppBar(potSetId: potSetId),
          ),
          body: ConcretePotSetBodyWidget(potSetId: potSetId),
        ),
      ),
    );
  }

  SnackBar errorSnackBar(String message) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      action: SnackBarAction(
        label: 'ОК',
        onPressed: () {},
      ),
    );
  }
}
