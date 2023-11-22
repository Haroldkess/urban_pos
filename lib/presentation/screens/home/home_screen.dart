import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/presentation/generalwidgets/SearchBox.dart';
import 'package:salesapp/presentation/generalwidgets/drawer.dart';
import 'package:salesapp/presentation/generalwidgets/gen_page.dart';
import 'package:salesapp/presentation/generalwidgets/text.dart';
import 'package:salesapp/presentation/screens/home/category_view/category_slide.dart';
import 'package:salesapp/presentation/screens/home/product_views/grid_views.dart';
import 'package:salesapp/presentation/screens/home/product_views/vertical_views.dart';
import 'package:salesapp/presentation/uiproviders/ui_provider.dart';
import 'package:salesapp/services/api_url.dart';
import 'package:salesapp/services/controllers/network_controller.dart';
import 'package:salesapp/services/controllers/operations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    UiProvider stream = context.watch<UiProvider>();
    return GenPage(
      title: "Home",
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
              child: Categories(),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child:
                    stream.onGrid ? const GridViews() : const VerticalViews())
          ],
        ),
      ),
      hasDash: true,
      hint: 'Search products',
      searchTrail: 'assets/icon/scan.svg',
      showFloat: true,
      showMenu: false,
      showFooter: false,
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // if (state == AppLifecycleState.inactive) return;

    final isBackground = state == AppLifecycleState.paused;
    final isClosed = state == AppLifecycleState.detached;
    final isResumed = state == AppLifecycleState.resumed;
    final isInactive = state == AppLifecycleState.inactive;

    if (isBackground) {
      consoleLog("background");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        CheckConnect.networkCheck(true, context);
      });
    } else if (isClosed) {
      consoleLog("closed");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        CheckConnect.networkCheck(true, context);
      });
    } else if (isResumed) {
      consoleLog("resumed");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        CheckConnect.networkCheck(true, context);
      });
    } else if (isInactive) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        CheckConnect.networkCheck(true, context);
      });
      consoleLog("inactive");
    }

    /* if (isBackground) {
      // service.stop();
    }
    
     else {
      // service.start();
    }*/
  }
}
