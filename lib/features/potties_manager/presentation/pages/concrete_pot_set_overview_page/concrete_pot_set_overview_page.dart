import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/failure.dart';
import '../../bloc/pots_actor/pots_bloc.dart';
import '../../bloc/pots_watcher/pots_watcher_bloc.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: PotSetAppBar(potSetId: potSetId),
      ),
      body: ConcretePotSetBodyWidget(potSetId: potSetId),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          BlocProvider.of<PotsBloc>(context).add(
            CreatePotEvent(
                potSetId: potSetId,
                isAmountFixed: false,
                percent: '15',
                name: 'test pot'),
          );
        },
      ),
    );
  }
}
