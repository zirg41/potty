import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:potty/features/potties_manager/domain/entities/pot_set.dart';
import 'package:potty/features/potties_manager/domain/repositories/pots_repository.dart';

part 'pots_event.dart';
part 'pots_state.dart';

class PotsBloc extends Bloc<PotsEvent, PotsState> {
  IPotsRepository potsRepository;

  PotsBloc({
    required this.potsRepository,
  }) : super(PotsInitial()) {
    on<PotsEvent>((event, emit) {});
    on<GetPotsEvent>((event, emit) {
      emit(LoadingState());
      final potsStream = potsRepository.getAllPots();
      potsStream.listen((event) {
        event.fold(
          (failure) => GetPotsErrorState(),
          (potSets) => PotSetsLoaded(potSets),
        );
      });
    });
  }
}
