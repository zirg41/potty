import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potty/features/potties_manager/domain/entities/pot.dart';
import 'package:potty/features/potties_manager/presentation/bloc/pots_actor/pots_bloc.dart';
import 'package:potty/features/potties_manager/presentation/pages/edit_pot_page/edit_pot_widget.dart';
import 'package:potty/features/potties_manager/presentation/pages/pot_sets_overview_page/widgets/pot_set_item.dart';

class PotItem extends StatelessWidget {
  final String potSetId;
  final Pot pot;

  const PotItem({
    Key? key,
    required this.potSetId,
    required this.pot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctxTheme = Theme.of(context);
    const snackBar = SnackBar(
      content: Text('Скопировано!'),
      duration: Duration(seconds: 1),
    );

    return Padding(
      padding: itemsPadding,
      child: Dismissible(
        key: ValueKey(pot.id),
        background: Container(
          margin: const EdgeInsets.all(0),
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(7)),
          child: const Icon(Icons.delete),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
        ),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) {
          if (direction == DismissDirection.endToStart) {
            return showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Вы уверены?"),
                content: const Text("Удалить данную позицию?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text("Нет",
                        style:
                            TextStyle(color: ctxTheme.colorScheme.onSurface)),
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
          }
          return Future.value(false);
        },
        onDismissed: (direction) {
          BlocProvider.of<PotsBloc>(context)
              .add(DeletePotEvent(potSetId: potSetId, potIdToDelete: pot.id));
        },
        child: InkWell(
          onTap: () async {
            await showDialog(
              context: context,
              builder: (ctx) {
                return EditPotWidget(
                  potSetId: potSetId,
                  editedPot: pot,
                );
              },
            );
          },
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            // color: Colors.transparent,
            margin: const EdgeInsets.all(0),
            child: Container(
              decoration: BoxDecoration(
                  color: ctxTheme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(7)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        // ПРОЦЕНТЫ
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                            color: ctxTheme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          pot.percent == null
                              ? ""
                              : "${pot.percent!.toStringAsFixed(pot.percent!.truncateToDouble() == pot.percent ? 0 : 1)} %",
                          style: const TextStyle(
                              fontSize: 18, color: Color(0xFFf4f1de)),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onLongPress: () {
                              Clipboard.setData(
                                  ClipboardData(text: pot.amount.toString()));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            child: Container(
                              // СУММА
                              margin: const EdgeInsets.all(5),
                              child: Text(
                                pot.amount != null
                                    ? pot.amount!.toStringAsFixed(
                                        pot.amount!.truncateToDouble() ==
                                                pot.amount
                                            ? 0
                                            : 2)
                                    : "-",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            // НАИМЕНОВАНИЕ
                            margin: const EdgeInsets.only(
                                left: 5, right: 5, top: 0, bottom: 5),
                            child: FittedBox(
                              child: Text(
                                pot.name,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
