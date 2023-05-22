import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../other_widgets/custom_snack_bar.dart';
import '../../../../domain/entities/pot.dart';
import '../../../bloc/pots_actor/pots_bloc.dart';
import '../../edit_pot_page/edit_pot_widget.dart';
import '../../pot_sets_overview_page/widgets/pot_set_item.dart';

class PotItem extends StatefulWidget {
  final String potSetId;
  final Pot pot;

  const PotItem({
    Key? key,
    required this.potSetId,
    required this.pot,
  }) : super(key: key);

  @override
  State<PotItem> createState() => _PotItemState();
}

class _PotItemState extends State<PotItem> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    final ctxTheme = Theme.of(context);
    bool isButtonEnabled = true;

    return BlocListener<PotsBloc, PotsState>(
      listener: (context, state) {
        if (state is UserEditingEitherNameOrIncomeOfPotSetState) {
          setState(() {
            isButtonEnabled = false;
            isEditing = false;
          });
        }
        if (state is PotsChangedSuccesfullyState) {
          setState(() {
            isButtonEnabled = true;
            isEditing = false;
          });
        }
      },
      child: Padding(
        padding: itemsPadding,
        child: Dismissible(
          key: ValueKey(widget.pot.id),
          background: Container(
            margin: const EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(7)),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete),
          ),
          direction: DismissDirection.endToStart,
          confirmDismiss: (direction) {
            if (direction == DismissDirection.endToStart) {
              return showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    "Вы уверены?",
                    style: ctxTheme.textTheme.displayLarge,
                  ),
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
            BlocProvider.of<PotsBloc>(context).add(DeletePotEvent(
                potSetId: widget.potSetId, potIdToDelete: widget.pot.id));
          },
          child: InkWell(
            onTap: () {
              if (isButtonEnabled) {
                setState(() {
                  isEditing = true;
                });
              } else {
                FocusManager.instance.primaryFocus?.unfocus();
                BlocProvider.of<PotsBloc>(context)
                    .add(const PotsChangedSuccesfullyEvent());
              }
            },
            child: isEditing
                ? EditPotWidget(
                    potSetId: widget.potSetId,
                    editedPot: widget.pot,
                  )
                : Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
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
                                  widget.pot.percent == null
                                      ? ""
                                      : "${widget.pot.percent!.toStringAsFixed(widget.pot.percent!.truncateToDouble() == widget.pot.percent ? 0 : 1)} %",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: ctxTheme.colorScheme.onPrimary),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onLongPress: () {
                                      Clipboard.setData(ClipboardData(
                                          text: widget.pot.amount.toString()));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(showCustomSnackBar(
                                              context, 'Скопировано!'));
                                    },
                                    child: Container(
                                      // СУММА
                                      margin: const EdgeInsets.all(5),
                                      child: Text(
                                        widget.pot.amount != null
                                            ? widget.pot.amount!
                                                .toStringAsFixed(widget
                                                            .pot.amount!
                                                            .truncateToDouble() ==
                                                        widget.pot.amount
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
                                        widget.pot.name,
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
      ),
    );
  }
}
