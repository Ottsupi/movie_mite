import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

void setupLogger() {
  final logger = Logger(
    filter: kDebugMode ? null : ProductionFilter(),
    printer: PrettyPrinter(
      lineLength: 80,
      colors: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );
  GetIt.I.registerLazySingleton<Logger>(() => logger);
}
