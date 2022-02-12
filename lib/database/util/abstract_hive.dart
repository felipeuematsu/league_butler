import 'package:hive/hive.dart';

abstract class AbstractHive {

  const AbstractHive();

  Future<void> init([String? subDir]);

  Future<Box<E>> openBox<E>(String name, HiveCipher encryptionCipher, bool Function(int entries, int deletedEntries) strategy);
}
