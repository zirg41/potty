import 'package:flutter/material.dart';
import 'package:potty/features/potties_manager/presentation/pages/edit_pot_page/edit_pot_widget.dart';
import 'package:potty/features/potties_manager/presentation/pages/pot_sets_overview_page/widgets/pot_set_item.dart';

class UnallocatedPot extends StatelessWidget {
  final double percent;
  final double amount;
  final String potSetId;

  const UnallocatedPot({
    required this.percent,
    required this.amount,
    required this.potSetId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contextTheme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        if (amount > 0.0) {
          showDialog(
            context: context,
            builder: (ctx) {
              return EditPotWidget(
                potSetId: potSetId,
                unallocatedAmount: amount.toString(),
                unallocatedPercent: percent.toString(),
              );
            },
          );
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        margin: itemsPadding,
        color: contextTheme.colorScheme.surface,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  // ПРОЦЕНТЫ
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: percent < 0.0
                          ? contextTheme.errorColor
                          : contextTheme.colorScheme.tertiary,
                      //border: Border.all(width: 8),
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "${percent.toStringAsFixed(percent.truncateToDouble() == percent ? 0 : 1)} %",
                    style:
                        const TextStyle(fontSize: 18, color: Color(0xFFf4f1de)),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // СУММА
                      margin: const EdgeInsets.all(5),
                      //padding: itemsPadding,
                      child: Text(
                        amount.toStringAsFixed(2),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      // НАИМЕНОВАНИЕ
                      //padding: itemsPadding,
                      margin: const EdgeInsets.only(
                          left: 5, right: 5, top: 0, bottom: 5),
                      child: FittedBox(
                        child: Text(
                          percent < 0.0 ? "Перераспределение" : "Остаток",
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
    );
  }
}
