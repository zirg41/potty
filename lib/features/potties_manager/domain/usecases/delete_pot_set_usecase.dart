import 'package:potty/features/potties_manager/domain/repositories/i_pots_repository.dart';

class DeletePotSetUseCase {
  IPotsRepository potsRepository;

  DeletePotSetUseCase({
    required this.potsRepository,
  });

  Future<void> call({
    required String potSetIdToDelete,
  }) async {
    await potsRepository.deletePotSet(potSetIdToDelete);
  }
}
