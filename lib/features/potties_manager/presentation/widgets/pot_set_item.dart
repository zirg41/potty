import 'package:flutter/material.dart';

class PotSetItem extends StatelessWidget {
  final String potSetName;
  final double potSetIncome;
  final DateTime potSetCreatedDate;
  final Function deletePotSet;

  const PotSetItem({
    Key? key,
    required this.potSetName,
    required this.potSetIncome,
    required this.potSetCreatedDate,
    required this.deletePotSet,
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
                potSetName,
                style: themeData.textTheme.bodyText1,
              ),
              subtitle: Text(
                potSetIncome.toString(),
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
                    deletePotSet;
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
