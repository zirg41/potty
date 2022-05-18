import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potty/features/potties_manager/presentation/pages/edit_pot_page/drop_down_values.dart';

import '../../../domain/entities/pot.dart';
import '../../bloc/pots_actor/pots_bloc.dart';

class EditPotWidget extends StatefulWidget {
  final String potSetId;
  final Pot? editedPot;
  final String? unallocatedAmount;
  final String? unallocatedPercent;

  const EditPotWidget({
    required this.potSetId,
    this.editedPot,
    this.unallocatedAmount,
    this.unallocatedPercent,
    Key? key,
  }) : super(key: key);

  @override
  State<EditPotWidget> createState() => _EditPotWidgetState();
}

class _EditPotWidgetState extends State<EditPotWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _percentController = TextEditingController();
  final _amountController = TextEditingController();

  bool _isEditing = false;
  Widget currentPotCreationOption =
      dropdownIconValues[DropValue.amount] as Icon;
  Pot? _editedPot;
  String previousPercentValue = '';
  String previousAmountValue = '';

  @override
  void initState() {
    _editedPot = widget.editedPot;
    if (_editedPot != null) {
      _isEditing = true;

      _nameController.text = _editedPot!.name;

      _amountController.text = _editedPot!.amount.toString();
      _percentController.text = _editedPot!.percent.toString();

      previousPercentValue = _amountController.text;
      previousAmountValue = _percentController.text;

      if (_editedPot!.isAmountFixed!) {
        currentPotCreationOption = dropdownIconValues[DropValue.amount] as Icon;
      } else {
        currentPotCreationOption =
            dropdownIconValues[DropValue.percent] as Icon;
      }
    }

    if (widget.unallocatedAmount != null || widget.unallocatedPercent != null) {
      _nameController.text = 'Остаток';

      _amountController.text = widget.unallocatedAmount!;
      _percentController.text = widget.unallocatedPercent!;
    }
    super.initState();
  }

  @override
  void dispose() {
    _percentController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeDataColorScheme = Theme.of(context).colorScheme;
    final ctxTheme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    final textFieldBorderRadius = BorderRadius.circular(10);
    final _enabledBorder = OutlineInputBorder(
        borderSide: BorderSide(width: 1.5, color: themeDataColorScheme.outline),
        borderRadius: textFieldBorderRadius);
    final _focusedBorder = OutlineInputBorder(
        borderSide:
            BorderSide(width: 1.5, color: themeDataColorScheme.onSurface),
        borderRadius: textFieldBorderRadius);
    final _errorBorder = OutlineInputBorder(
        borderSide: BorderSide(width: 1.5, color: themeDataColorScheme.error),
        borderRadius: textFieldBorderRadius);

    bool isAmountFixedByUser =
        currentPotCreationOption == dropdownIconValues[DropValue.amount];
    // ! build function return
    return BlocListener<PotsBloc, PotsState>(
      listener: (context, state) {
        if (state is PercentOrAmountInputErrorState) {
          // TODO try to add error state of textField (red field while error)
          _amountController.text = previousPercentValue;
          _percentController.text = previousAmountValue;

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
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            Center(
              child: Container(
                alignment: Alignment.center,
                height: mediaQuery.size.height * 0.35,
                width: mediaQuery.size.width * 0.7,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: ctxTheme.colorScheme.surface,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              // ! Pot's name Text Field
                              TextFormField(
                                controller: _nameController,
                                autocorrect: false,
                                autofocus: true,
                                keyboardType: TextInputType.name,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  hintText: 'Наименование',
                                  enabledBorder: _enabledBorder,
                                  focusedBorder: _focusedBorder,
                                  errorBorder: _errorBorder,
                                  suffixIcon: IconButton(
                                    onPressed: _nameController.clear,
                                    color: themeDataColorScheme.outline,
                                    focusColor: themeDataColorScheme.onSurface,
                                    icon: const Icon(Icons.clear),
                                  ),
                                ),
                                textInputAction: TextInputAction.next,
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // ! Percent&Amount Text Field
                                  SizedBox(
                                    width: constraints.maxWidth * 0.65,
                                    child: TextFormField(
                                      controller: isAmountFixedByUser
                                          ? _amountController
                                          : _percentController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        enabledBorder: _enabledBorder,
                                        focusedBorder: _focusedBorder,
                                        errorBorder: _errorBorder,
                                        hintText: isAmountFixedByUser
                                            ? 'Сумма'
                                            : 'Проценты',
                                        suffixIcon: IconButton(
                                          onPressed: isAmountFixedByUser
                                              ? () => _amountController.clear()
                                              : () =>
                                                  _percentController.clear(),
                                          color: themeDataColorScheme.outline,
                                          focusColor:
                                              themeDataColorScheme.onSurface,
                                          icon: const Icon(Icons.clear),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // ! Dropdown button
                                  Container(
                                    width: constraints.maxWidth * 0.3,
                                    height: 59,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1.5,
                                        color: themeDataColorScheme.outline,
                                      ),
                                      borderRadius: textFieldBorderRadius,
                                    ),
                                    child: Center(
                                      child: DropdownButton<Widget>(
                                        alignment: Alignment.center,
                                        value: currentPotCreationOption,
                                        icon: const Icon(
                                            Icons.arrow_drop_down_outlined),
                                        underline: const SizedBox.shrink(),
                                        isExpanded: false,
                                        isDense: false,
                                        onChanged: (Widget? newValue) {
                                          if (newValue == null) {
                                            return;
                                          }
                                          setState(() {
                                            currentPotCreationOption = newValue;

                                            if (newValue ==
                                                dropdownIconValues[
                                                    DropValue.percent]) {
                                              isAmountFixedByUser = false;
                                            }
                                            if (newValue ==
                                                dropdownIconValues[
                                                    DropValue.amount]) {
                                              isAmountFixedByUser = true;
                                            }
                                          });
                                        },
                                        items: dropdownIconValues.values
                                            .map(
                                              (value) => DropdownMenuItem(
                                                  child: value, value: value),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('Отменить')),
                                  ElevatedButton(
                                      onPressed: () {
                                        if (_isEditing) {
                                          // ! Editing existing Pot
                                          BlocProvider.of<PotsBloc>(context)
                                              .add(
                                            EditPotEvent(
                                              potSetId: widget.potSetId,
                                              potId: _editedPot!.id,
                                              isAmountFixed:
                                                  isAmountFixedByUser,
                                              percent: !isAmountFixedByUser
                                                  ? _percentController.text
                                                  : '0',
                                              amount: isAmountFixedByUser
                                                  ? _amountController.text
                                                  : '0',
                                              name: _nameController.text,
                                            ),
                                          );
                                        } else {
                                          // ! Creation new Pot
                                          BlocProvider.of<PotsBloc>(context)
                                              .add(
                                            CreatePotEvent(
                                              potSetId: widget.potSetId,
                                              isAmountFixed:
                                                  isAmountFixedByUser,
                                              percent: !isAmountFixedByUser
                                                  ? _percentController.text
                                                  : null,
                                              amount: isAmountFixedByUser
                                                  ? _amountController.text
                                                  : null,
                                              name: _nameController.text,
                                            ),
                                          );
                                        }
                                      },
                                      child: const Text('Сохранить')),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
