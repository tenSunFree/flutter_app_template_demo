import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../common/utils/provider.dart';
import '../res/theme.dart';
import 'main/main_page.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'flutter_app_template_demo',
      useInheritedMediaQuery: true,
      theme: getAppTheme(),
      darkTheme: getAppThemeDark(),
      navigatorKey: ref.watch(navigatorStateKeyProvider),
      debugShowCheckedModeBanner: true,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja', 'JP'),
      ],
      home: const MainPage(),
    );
  }
}
