import 'package:get/get.dart';
import 'package:league_butler/commons/interfaces/abstract_translations.dart';

class HomeTranslations extends AbstractTranslations {

  @override
  final ptBr = {
  };

  @override
  final enUs = {
  };

}

enum HomeStrings {
  // Add your strings here
  x,
}

extension HomeStringsExt on HomeStrings {

  String get tr => toString().tr;

}