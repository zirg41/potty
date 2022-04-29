import 'package:potty/features/potties_manager/domain/entities/sorting_logic.dart';

import '../repositories/i_pots_repository.dart';

class SetSortingUseCase {
  IPotsRepository potsRepository;
  late SortingLogic sortingLogic;

  SetSortingUseCase({
    required this.potsRepository,
    this.sortingLogic = SortingLogic.highToLow,
  });

  Future<void> call(
      {required String potSetId, required SortingLogic sortingLogic}) async {
    await potsRepository.setSorting(potSetId, sortingLogic);
  }
}
