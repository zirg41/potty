import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global/misc.dart';
import '../../domain/entities/pot_set.dart';
import '../bloc/pots_actor/pots_bloc.dart';
import '../routes/router.gr.dart';

class PotSetItem extends StatelessWidget {
  final PotSet potset;

  const PotSetItem({
    Key? key,
    required this.potset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return GestureDetector(
      // TODO Navigate to concrete pot
      onTap: () => _navigateToConcretePotSet(context, potset),
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text(
                // TODO Change id showing to name
                potset.name,
                style: themeData.textTheme.bodyText1,
              ),
              subtitle: Row(
                children: [
                  Text(
                    potset.income.toString(),
                    style: themeData.textTheme.subtitle1,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    potSetDateFormat.format(potset.createdDate),
                    style: themeData.textTheme.subtitle1,
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  final bool response = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Вы уверены?"),
                      content: const Text("Удалить данную позицию?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text("Нет"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: const Text(
                            "Да",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                  if (response) {
                    BlocProvider.of<PotsBloc>(context)
                        .add(DeletePotSetEvent(potSetIdToDelete: potset.id));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToConcretePotSet(BuildContext context, PotSet potSet) {
    AutoRouter.of(context).push(ConcretePotSetOverviewRoute(potSet: potSet));
  }
}
