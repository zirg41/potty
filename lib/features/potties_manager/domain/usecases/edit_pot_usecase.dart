import '../../../../core/util/pot_creator.dart';
import '../entities/pot.dart';
import '../repositories/i_pots_repository.dart';

class EditPotUseCase {
  final IPotsRepository potsRepository;
  late IPotCreator potCreator;

  EditPotUseCase({required this.potsRepository});

  Future<void> call({
    required String potSetId,
    required String potId,
    String name = 'default name',
    bool isAmountFixed = false,
    double? amount,
    double? percent,
    IPotCreator? potCreator,
  }) async {
    Pot updatedPot = Pot(
      id: potId,
      name: name,
      isAmountFixed: isAmountFixed,
      amount: amount,
      percent: percent,
    );
    Pot? manualPot = potCreator?.call();

    await potsRepository.updatePot(potSetId, potId, manualPot ?? updatedPot);
  }
}
