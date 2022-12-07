import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'common/utils/flavor.dart';
import 'common/utils/logger.dart';
import 'presentation/pages/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.configure();
  await Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
  ]);
  logger.info(Flavor.environment);
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
