import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../global/misc.dart';
import '../../../../domain/entities/pot_set.dart';
import '../../../bloc/pots_actor/pots_bloc.dart';
import '../../../routes/router.gr.dart';

const itemsPadding = EdgeInsets.symmetric(vertical: 7, horizontal: 13);

class PotSetItem extends StatelessWidget {
  final PotSet potset;

  const PotSetItem({
    Key? key,
    required this.potset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    var potsBloc = BlocProvider.of<PotsBloc>(context);
    return GestureDetector(
      onTap: () {
        context.pushRoute(ConcretePotSetOverviewRoute(potSetId: potset.id));
      },
      child: Padding(
        padding: itemsPadding,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          color: themeData.colorScheme.surface,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  potset.name,
                  style: themeData.textTheme.bodyLarge,
                ),
                subtitle: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      potset.income.toString(),
                      style: themeData.textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      potSetDateFormat.format(potset.createdDate),
                      style: themeData.textTheme.bodySmall,
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final bool response = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          "Вы уверены?",
                          style: themeData.textTheme.displayLarge,
                        ),
                        content: const Text("Удалить данную позицию?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text(
                              "Нет",
                              style: themeData.textTheme.bodyMedium,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: Text(
                              "Да",
                              style: themeData.textTheme.bodyMedium!
                                  .copyWith(color: themeData.colorScheme.error),
                            ),
                          ),
                        ],
                      ),
                    );
                    if (response) {
                      potsBloc
                          .add(DeletePotSetEvent(potSetIdToDelete: potset.id));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
