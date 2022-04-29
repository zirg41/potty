import '../../../../core/util/id_generator.dart';
import '../../../../core/util/pot_creator.dart';
import '../entities/pot.dart';
import '../repositories/i_pots_repository.dart';

class CreatePotUseCase {
  IPotsRepository potsRepository;
  IDGenerator idGenerator;
  late IPotCreator potCreator;

  CreatePotUseCase({
    required this.potsRepository,
    required this.idGenerator,
    potCreator = const EmptyPot(),
  });

  Future<void> call({
    required String potSetId,
    String name = 'default name',
    bool isAmountFixed = false,
    double? amount,
    double? percent,
    IPotCreator? potCreator,
  }) async {
    Pot newPot = Pot(
      id: idGenerator.generateID(),
      name: name,
      isAmountFixed: isAmountFixed,
      amount: amount,
      percent: percent,
    );
    Pot? manualPot = potCreator?.call();
    await potsRepository.addPot(
        potSetId,
        manualPot ?? newPot
          ..id = idGenerator.generateID());
  }
}
