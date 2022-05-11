// ignore_for_file: constant_identifier_names

import 'package:dartz/dartz.dart';
import 'package:potty/core/errors/failure.dart';

class InputConverter {
  Either<Failure, double> stringToUnsignedDouble(String str) {
    try {
      final parsedAmount = double.parse(str);
      if (parsedAmount < 0) {
        throw const FormatException();
      }
      return Right(parsedAmount);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
