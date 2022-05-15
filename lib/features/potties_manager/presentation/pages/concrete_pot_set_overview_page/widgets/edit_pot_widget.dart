import 'package:flutter/material.dart';
import 'package:potty/features/potties_manager/domain/entities/pot.dart';

class EditPotWidget extends StatefulWidget {
  EditPotWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<EditPotWidget> createState() => _EditPotWidgetState();
}

class _EditPotWidgetState extends State<EditPotWidget> {
  var _isEditing;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  Pot? _editedPot = Pot(
    id: 'null',
    name: "",
    percent: null,
    amount: null,
  );

  final percentAmountController = TextEditingController();

  String currentDropdownValue = 'Сумма';

  @override
  Widget build(BuildContext context) {
    final themeDataColorScheme = Theme.of(context).colorScheme;
    final ctxTheme = Theme.of(context);

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

    // ! build function return
    return FractionallySizedBox(
      alignment: const Alignment(0.0, -0.5),
      widthFactor: 0.8,
      heightFactor: 0.35,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: ctxTheme.colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      autocorrect: false,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.65,
                          child: TextFormField(
                            decoration: InputDecoration(
                                enabledBorder: _enabledBorder,
                                focusedBorder: _focusedBorder,
                                errorBorder: _errorBorder,
                                hintText: 'Сумма'),
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.3,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: themeDataColorScheme.outline,
                              ),
                              borderRadius: textFieldBorderRadius,
                            ),
                            child: DropdownButton<String>(
                              value: currentDropdownValue,
                              icon: const Icon(Icons.arrow_drop_down_outlined),
                              style: TextStyle(
                                  color: themeDataColorScheme.primary,
                                  fontSize: 15),
                              underline: const SizedBox.shrink(),
                              isExpanded: true,
                              onChanged: (String? newValue) {
                                if (newValue == null) {
                                  return;
                                }
                                setState(() {
                                  if (_isEditing) {
                                    currentDropdownValue = newValue;
                                    if (newValue ==
                                        dropdownValues[DropValue.percent]) {
                                      percentAmountController.text =
                                          _editedPot!.percent.toString();
                                    }
                                    if (newValue ==
                                        dropdownValues[DropValue.amount]) {
                                      percentAmountController.text =
                                          _editedPot!.amount.toString();
                                    }
                                  }
                                });
                              },
                              items: dropdownValues.values
                                  .map(
                                    (value) => DropdownMenuItem(
                                      child: Text(value),
                                      value: value,
                                    ),
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
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Отменить')),
                        ElevatedButton(
                            onPressed: () {}, child: const Text('Сохранить')),
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

enum DropValue { percent, amount }

const Map<DropValue, String> dropdownValues = {
  DropValue.percent: 'Проценты',
  DropValue.amount: 'Сумма'
};
