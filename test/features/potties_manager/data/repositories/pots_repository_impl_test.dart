import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:potty/features/potties_manager/data/datasources/i_local_datasource.dart';
import 'package:potty/features/potties_manager/data/repositories/pots_repository_impl.dart';
import 'package:potty/features/potties_manager/domain/entities/pot_set.dart';

import '../../domain/entities/pot_set_test.dart';

class MockLocalDatasource extends Mock implements ILocalDatasource {}

final mockPotSet = PotSet(
  id: 'potSetid',
  income: 100,
  name: 'name',
  pots: [],
  createdDate: DateTime.now(),
);
void main() {
  late PotsRepositoryImpl potsRepository;
  late MockLocalDatasource mockLocalDatasource;

  setUp(() {
    mockLocalDatasource = MockLocalDatasource();
    potsRepository = PotsRepositoryImpl(localDatasource: mockLocalDatasource);
    potsRepository.potsets = [mockPotSet];
  });

  group(
    'PotsRepositoryImpl',
    () {
      test(
        "should invoke saveToMemory method while adding new Pot",
        () async {
          // arrange
          //when(mockLocalDatasource.saveToMemory(mockPotSet))
          //  .thenAnswer((realInvocation) => Future.value(Future<void>));
          // act
          //potsRepository.addPot("potSetid", pot1);
          // assert
          // TODO verify(mockLocalDatasource.saveToMemory(potsRepository.potsets[0]));
        },
      );
    },
  );
}
