import '../../../../core/util/id_generator.dart';
import '../../../../core/util/pots_creator.dart';
import '../entities/pot_set.dart';
import '../repositories/i_pots_repository.dart';

class CreatePotSetUseCase {
  late PotSet potSet;
  final IPotsRepository potsRepository;
  final IDGenerator idGenerator;

  CreatePotSetUseCase({
    required this.potsRepository,
    required this.idGenerator,
  });

  Future<void> call(String name, double income,
      {IPotsCreator potsCreator = const EmptyPotsCreator()}) async {
    potSet = PotSet(
      id: idGenerator.generateID(),
      income: income,
      name: name,
      createdDate: DateTime.now(),
      pots: potsCreator(),
    );
    await potsRepository.addPotSet(potSet);
  }
}
