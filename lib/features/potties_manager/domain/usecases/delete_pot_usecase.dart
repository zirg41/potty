import '../repositories/i_pots_repository.dart';

class DeletePotUseCase {
  IPotsRepository potsRepository;

  DeletePotUseCase({
    required this.potsRepository,
  });

  Future<void> call({
    required String potSetId,
    required String potIdToDelete,
  }) async {
    await potsRepository.deletePot(potSetId, potIdToDelete);
  }
}
