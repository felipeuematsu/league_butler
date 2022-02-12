import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printTime: true,
  ),
);
