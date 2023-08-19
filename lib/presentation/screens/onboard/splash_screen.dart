import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/controllers/operations.dart';
import '../../../services/temps/temp_store.dart';
import '../../constant/colors.dart';
import '../../generalwidgets/text.dart';
import 'login_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late SharedPreferences pref;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //   SvgPicture.asset("assets/icon/splash.svg", height: 74, width: 81),
            // Image.asset("assets/pic/ogaboss.png", height: 74, width: 81),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AppText(
                text: "Ogaboss",
                color: blue,
                size: 38,
                align: TextAlign.center,
                fontWeight: FontWeight.w700,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            AppText(
              text: "For Vendors",
              color: blue,
              size: 16,
              align: TextAlign.center,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Operations.checkSessionStat(context);
    });

    //   LoginController.makeRequest(context);
    // CartController.getCartInitData(context);
    // OrderController.getOrderInitData(context);
  }
}
