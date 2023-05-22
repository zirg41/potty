import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../other_widgets/custom_snack_bar.dart';
import 'drop_down_values.dart';

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
  final _percentAmountFocusNode = FocusNode();

  String _previousPercentValue = '';
  String _previousAmountValue = '';

  bool _isEditing = false;
  Widget _currentPotCreationOption =
      dropdownIconValues[DropValue.amount] as Icon;
  Pot? _editedPot;

  @override
  void initState() {
    _editedPot = widget.editedPot;
    if (_editedPot != null) {
      _isEditing = true;

      _nameController.text = _editedPot!.name;

      _amountController.text = _editedPot!.amount.toString();
      _percentController.text = _editedPot!.percent.toString();

      _previousPercentValue = _amountController.text;
      _previousAmountValue = _percentController.text;

      if (_editedPot!.isAmountFixed!) {
        _currentPotCreationOption =
            dropdownIconValues[DropValue.amount] as Icon;
      } else {
        _currentPotCreationOption =
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

  void _saveForm(BuildContext context, bool isAmountFixedByUser) {
    if (_isEditing) {
      // ! Editing existing Pot
      BlocProvider.of<PotsBloc>(context).add(
        EditPotEvent(
          potSetId: widget.potSetId,
          potId: _editedPot!.id,
          isAmountFixed: isAmountFixedByUser,
          percent: !isAmountFixedByUser ? _percentController.text : '0',
          amount: isAmountFixedByUser ? _amountController.text : '0',
          name: _nameController.text,
        ),
      );
    } else {
      // ! Creation new Pot
      BlocProvider.of<PotsBloc>(context).add(
        CreatePotEvent(
          potSetId: widget.potSetId,
          isAmountFixed: isAmountFixedByUser,
          percent: !isAmountFixedByUser ? _percentController.text : null,
          amount: isAmountFixedByUser ? _amountController.text : null,
          name: _nameController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeDataColorScheme = Theme.of(context).colorScheme;
    final ctxTheme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    final textFieldBorderRadius = BorderRadius.circular(10);
    final enabledBorder = OutlineInputBorder(
        borderSide: BorderSide(width: 1.5, color: themeDataColorScheme.outline),
        borderRadius: textFieldBorderRadius);
    final focusedBorder = OutlineInputBorder(
        borderSide:
            BorderSide(width: 1.5, color: themeDataColorScheme.onSurface),
        borderRadius: textFieldBorderRadius);
    final errorBorder = OutlineInputBorder(
        borderSide: BorderSide(width: 1.5, color: themeDataColorScheme.error),
        borderRadius: textFieldBorderRadius);

    bool isAmountFixedByUser =
        _currentPotCreationOption == dropdownIconValues[DropValue.amount];
    // ! build function return
    return BlocListener<PotsBloc, PotsState>(
      listener: (context, state) {
        if (state is PercentOrAmountInputErrorState) {
          // TODO try to add error state of textField (red field while error)
          _amountController.text = _previousPercentValue;
          _percentController.text = _previousAmountValue;

          ScaffoldMessenger.of(context).showSnackBar(
            showCustomSnackBar(context, state.message),
          );
          BlocProvider.of<PotsBloc>(context)
              .add(const UserIsFixingInputErrorEvent());
        }
        if (state is PotsChangedSuccesfullyState) {
          FocusManager.instance.primaryFocus?.unfocus();
          // Navigator.of(context).pop();
        }
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        // color: Colors.transparent,
        margin: const EdgeInsets.all(0),
        color: ctxTheme.colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(15),
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
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        _percentAmountFocusNode.requestFocus();
                      },
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: 'Наименование',
                        enabledBorder: enabledBorder,
                        focusedBorder: focusedBorder,
                        errorBorder: errorBorder,
                        suffixIcon: IconButton(
                          onPressed: _nameController.clear,
                          color: themeDataColorScheme.outline,
                          focusColor: themeDataColorScheme.onSurface,
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // ! Percent&Amount Text Field
                        SizedBox(
                          width: constraints.maxWidth * 0.65,
                          child: TextFormField(
                            controller: isAmountFixedByUser
                                ? _amountController
                                : _percentController,
                            keyboardType: TextInputType.number,
                            focusNode: _percentAmountFocusNode,
                            onFieldSubmitted: (_) =>
                                _saveForm(context, isAmountFixedByUser),
                            decoration: InputDecoration(
                              enabledBorder: enabledBorder,
                              focusedBorder: focusedBorder,
                              errorBorder: errorBorder,
                              hintText:
                                  isAmountFixedByUser ? 'Сумма' : 'Проценты',
                              suffixIcon: IconButton(
                                onPressed: isAmountFixedByUser
                                    ? () => _amountController.clear()
                                    : () => _percentController.clear(),
                                color: themeDataColorScheme.outline,
                                focusColor: themeDataColorScheme.onSurface,
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
                              onTap: () =>
                                  _percentAmountFocusNode.requestFocus(),
                              alignment: Alignment.center,
                              value: _currentPotCreationOption,
                              icon: const Icon(Icons.arrow_drop_down_outlined),
                              underline: const SizedBox.shrink(),
                              isExpanded: false,
                              isDense: false,
                              onChanged: (Widget? newValue) {
                                if (newValue == null) {
                                  return;
                                }
                                setState(() {
                                  _currentPotCreationOption = newValue;

                                  if (newValue ==
                                      dropdownIconValues[DropValue.percent]) {
                                    isAmountFixedByUser = false;
                                  }
                                  if (newValue ==
                                      dropdownIconValues[DropValue.amount]) {
                                    isAmountFixedByUser = true;
                                  }
                                });
                              },
                              items: dropdownIconValues.values
                                  .map(
                                    (value) => DropdownMenuItem(
                                        value: value, child: value),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: () => BlocProvider.of<PotsBloc>(context)
                                .add(const PotsChangedSuccesfullyEvent()),
                            child: const Text('Отменить')),
                        ElevatedButton(
                          child: const Text('Сохранить'),
                          onPressed: () =>
                              _saveForm(context, isAmountFixedByUser),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
