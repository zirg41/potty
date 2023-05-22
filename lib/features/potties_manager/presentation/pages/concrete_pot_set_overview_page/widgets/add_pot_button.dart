import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/pots_actor/pots_bloc.dart';
import '../../edit_pot_page/edit_pot_widget.dart';
import '../../pot_sets_overview_page/widgets/pot_set_item.dart';

class AddPotButton extends StatefulWidget {
  final String potSetId;

  const AddPotButton({
    required this.potSetId,
    Key? key,
  }) : super(key: key);

  @override
  State<AddPotButton> createState() => _AddPotButtonState();
}

class _AddPotButtonState extends State<AddPotButton> {
  bool? isPotEditWidgetShow = false;
  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled = true;

    final contextTheme = Theme.of(context);
    return BlocListener<PotsBloc, PotsState>(
      listener: (context, state) {
        if (state is UserEditingEitherNameOrIncomeOfPotSetState) {
          setState(() {
            isButtonEnabled = false;
            isPotEditWidgetShow = false;
          });
        }
        if (state is PotsChangedSuccesfullyState) {
          setState(() {
            isButtonEnabled = true;
            isPotEditWidgetShow = false;
          });
        }
      },
      child: GestureDetector(
        onTap: () {
          if (isButtonEnabled) {
            // showDialog(
            //   context: context,
            //   builder: (ctx) {
            //     return EditPotWidget(
            //       potSetId: potSetId,
            //     );
            //   },
            // );

            setState(() {
              isPotEditWidgetShow = true;
            });
          } else {
            setState(() {
              isPotEditWidgetShow = false;
              // FocusManager.instance.primaryFocus?.unfocus();
              BlocProvider.of<PotsBloc>(context)
                  .add(const PotsChangedSuccesfullyEvent());
            });
          }
        },
        child: isPotEditWidgetShow!
            ? Container(
                padding: const EdgeInsets.fromLTRB(13, 7, 13, 0),
                child: EditPotWidget(
                  potSetId: widget.potSetId,
                ),
              )
            : Padding(
                padding: itemsPadding,
                child: Card(
                  elevation: 5,
                  color: contextTheme.colorScheme.surface,
                  child: const SizedBox(
                    height: 50,
                    child: Center(
                      child: Icon(Icons.add),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
