import 'package:uuid/uuid.dart';

abstract class IDGenerator {
  String generateID();
}

class PotSetIdGenerator implements IDGenerator {
  @override
  String generateID() {
    return const Uuid().v4();
  }
}

class PotIdGenerator implements IDGenerator {
  @override
  String generateID() {
    return DateTime.now().toIso8601String();
  }
}
