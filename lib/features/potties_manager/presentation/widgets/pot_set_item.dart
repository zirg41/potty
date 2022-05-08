import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../dependency_injection.dart';
import '../bloc/pots_actor/pots_bloc.dart';

import '../../domain/entities/pot_set.dart';

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
      onTap: () => _navigateToConcretePot(context),
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text(
                // TODO Change id showing to name
                potset.id,
                style: themeData.textTheme.bodyText1,
              ),
              subtitle: Text(
                potset.income.toString(),
                style: themeData.textTheme.subtitle1,
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
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text("Нет"),
                        ),
                        FlatButton(
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

  void _navigateToConcretePot(BuildContext context) {}
}
