import '../repositories/i_pots_repository.dart';

class EditPotSetUseCase {
  IPotsRepository potsRepository;

  EditPotSetUseCase({
    required this.potsRepository,
  });

  Future<void> changePotSetName(
      {required String potSetId, required String newName}) async {
    await potsRepository.changePotSetName(potSetId, newName);
  }

  Future<void> changePotSetIncome(
      {required String potSetId, required double newIncome}) async {
    await potsRepository.changePotSetIncome(potSetId, newIncome);
  }
}
