import 'package:flutter/material.dart';
import 'package:flutter_app_template_demo/common/extensions/context_extension.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import '../../../common/gen/colors.gen.dart';
import '../sport/sport_page.dart';
import 'tab_navigator.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  static Future<void> show(BuildContext context) =>
      Navigator.of(context, rootNavigator: true).pushReplacement<void, void>(
        PageTransition(
          type: PageTransitionType.fade,
          child: const MainPage(),
          duration: const Duration(milliseconds: 500),
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgets = useState<List<Widget>>([
      Container(alignment: Alignment.center, child: const Text('真心推薦')),
      Container(alignment: Alignment.center, child: const Text('電視館')),
      const SportPage(),
      Container(alignment: Alignment.center, child: const Text('影劇館')),
      Container(alignment: Alignment.center, child: const Text('單次付費')),
    ]);
    final navigatorKeys = useState([
      GlobalKey<NavigatorState>(),
      GlobalKey<NavigatorState>(),
      GlobalKey<NavigatorState>(),
      GlobalKey<NavigatorState>(),
      GlobalKey<NavigatorState>(),
    ]);
    final selectedIndex = useState(0);
    return WillPopScope(
      onWillPop: () async {
        final keyTab = navigatorKeys.value[selectedIndex.value];
        if (keyTab.currentState != null && keyTab.currentState!.canPop()) {
          return !await keyTab.currentState!.maybePop();
        }
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: List.generate(
            widgets.value.length,
            (index) => Offstage(
              offstage: index != selectedIndex.value,
              child: TabNavigator(
                navigatorKey: navigatorKeys.value[index],
                page: widgets.value[index],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.heart_broken),
              label: '真心推薦',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.tv),
              label: '電視館',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_basketball),
              label: '運動館',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.play_circle_filled_outlined),
              label: '影劇館',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined),
              label: '單次付費',
              tooltip: '',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex.value,
          showSelectedLabels: !context.isIphoneMiniSize,
          showUnselectedLabels: !context.isIphoneMiniSize,
          onTap: (index) {
            selectedIndex.value = index;
          },
          selectedLabelStyle:
              const TextStyle(color: ColorName.cFFFFFFFF, fontSize: 16),
          unselectedLabelStyle:
              const TextStyle(color: ColorName.cFF4D4D4D, fontSize: 12),
          selectedItemColor: ColorName.cFFFFFFFF,
          unselectedItemColor: ColorName.cFF4D4D4D,
        ),
      ),
    );
  }
}
