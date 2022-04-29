import 'package:potty/core/util/id_generator.dart';
import 'package:potty/core/util/pots_creator.dart';
import 'package:potty/features/potties_manager/domain/entities/pot_set.dart';
import 'package:potty/features/potties_manager/domain/repositories/i_pots_repository.dart';

class CreatePotSetUseCase {
  late PotSet potSet;
  final IPotsRepository potsRepository;
  final IDGenerator idGenerator;

  CreatePotSetUseCase({
    required this.potsRepository,
    required this.idGenerator,
  });

  Future<void> call(String name, double income,
      {PotsCreator potsCreator = const EmptyPotsCreator()}) async {
    potSet = PotSet(
      id: idGenerator.generateID(),
      income: income,
      name: name,
      createdDate: DateTime.now(),
      pots: potsCreator(),
    );
    potsRepository.addPotSet(potSet);
  }
}
