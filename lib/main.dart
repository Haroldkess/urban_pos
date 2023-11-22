import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/presentation/screens/home/home_screen.dart';
import 'package:salesapp/presentation/screens/onboard/splash_screen.dart';
import 'package:salesapp/presentation/uiproviders/ui_provider.dart';
import 'package:salesapp/services/backoffice/db.dart';
import 'package:salesapp/services/controllers/cart_controller.dart';
import 'package:salesapp/services/controllers/login_controller.dart';
import 'package:salesapp/services/controllers/network_controller.dart';
import 'package:salesapp/services/controllers/order_controller.dart';
import 'package:salesapp/services/middleware/server_thread.dart';
import 'package:salesapp/services/provider_init.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Database.initDatabase();
  initSyncWorker();
  CheckConnect.networkCheck(false);
  Get.put(DescriprionController());

  runApp(MultiProvider(
      providers: InitProvider.providerInit(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
        child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SalesApp',
      theme: ThemeData(),
      home: const FirstRun(),
    ));
  }
}

class FirstRun extends StatelessWidget {
  const FirstRun({super.key});

  @override
  Widget build(BuildContext context) {
    return const Splash();
  }
}
