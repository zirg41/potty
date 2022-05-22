import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/pots_actor/pots_bloc.dart';

class CreatePotSetBody extends StatefulWidget {
  const CreatePotSetBody({Key? key}) : super(key: key);

  @override
  State<CreatePotSetBody> createState() => _CreatePotSetBodyState();
}

class _CreatePotSetBodyState extends State<CreatePotSetBody> {
  final _formKey = GlobalKey<FormState>();
  final _incomeController = TextEditingController();
  final _nameController = TextEditingController();
  final _incomeAmountFocusNode = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _previousIncomeValue = '';

  void _saveForm(BuildContext context) {
    BlocProvider.of<PotsBloc>(context).add(
      CreatePotSetEvent(
        name: _nameController.text,
        income: _incomeController.text,
      ),
    );
  }

  @override
  void dispose() {
    _incomeController.dispose();
    _nameController.dispose();
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

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      body: BlocListener<PotsBloc, PotsState>(
        listener: (context, state) => _stateHandler(context, state),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            Column(
              children: [
                const SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          maxHeight: mediaQuery.size.height * 0.35,
                          maxWidth: mediaQuery.size.width * 0.7),
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
                                    // ! PotSet's name Text Field
                                    TextFormField(
                                      controller: _nameController,
                                      autocorrect: false,
                                      autofocus: true,
                                      keyboardType: TextInputType.name,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (value) {
                                        _incomeAmountFocusNode.requestFocus();
                                      },
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
                                          focusColor:
                                              themeDataColorScheme.onSurface,
                                          icon: const Icon(Icons.clear),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    // ! Income text field
                                    TextFormField(
                                      controller: _incomeController,
                                      keyboardType: TextInputType.number,
                                      focusNode: _incomeAmountFocusNode,
                                      onFieldSubmitted: (_) =>
                                          _saveForm(context),
                                      decoration: InputDecoration(
                                        enabledBorder: _enabledBorder,
                                        focusedBorder: _focusedBorder,
                                        errorBorder: _errorBorder,
                                        hintText: 'Доход, RUB',
                                        suffixIcon: IconButton(
                                          onPressed: () =>
                                              _incomeController.clear(),
                                          color: themeDataColorScheme.outline,
                                          focusColor:
                                              themeDataColorScheme.onSurface,
                                          icon: const Icon(Icons.clear),
                                        ),
                                      ),
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
                                          child: const Text('Сохранить'),
                                          onPressed: () => _saveForm(context),
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
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _stateHandler(BuildContext context, PotsState state) {
    if (state is IncomeInputErrorState) {
      _incomeController.text = _previousIncomeValue;

      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(state.message),
          action: SnackBarAction(
            label: 'ОКjkl',
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
  }
}
