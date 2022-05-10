import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/pot_set.dart';
import '../repositories/i_pots_repository.dart';

/// Unusable usecase. Better listen directly from repository
class ListenPotSetsStreamUseCase {
  IPotsRepository potsRepository;

  ListenPotSetsStreamUseCase({
    required this.potsRepository,
  });

  Stream<Either<Failure, List<PotSet>>> call() async* {
    yield* potsRepository.getPotsStream();
  }
}
