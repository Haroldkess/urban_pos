import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/presentation/constant/colors.dart';
import 'package:salesapp/presentation/functions/allNavigation.dart';
import 'package:salesapp/presentation/generalwidgets/logout_dialogue.dart';
import 'package:salesapp/presentation/generalwidgets/text.dart';
import 'package:salesapp/presentation/screens/draft/draft_screen.dart';
import 'package:salesapp/presentation/screens/home/home_screen.dart';
import 'package:salesapp/presentation/screens/orders/order_screen.dart';
import 'package:salesapp/services/controllers/login_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../services/controllers/operations.dart';
import '../../services/controllers/order_controller.dart';

class DrawerSide extends StatefulWidget {
  final GlobalKey<ScaffoldState> scafKey;
  const DrawerSide({super.key, required this.scafKey});

  @override
  State<DrawerSide> createState() => _DrawerSideState();
}

class _DrawerSideState extends State<DrawerSide> {
  @override
  Widget build(BuildContext context) {
    LoginProvider user = context.watch<LoginProvider>();
    return Drawer(
      backgroundColor: Colors.white,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Column(
            children: [
              DrawerHeader(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(color: HexColor("#F9FAFB")),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: HexColor("#CED7ED"),
                              backgroundImage: CachedNetworkImageProvider(user
                                      .shopModel.data!.user!.image ??
                                  "https://pbs.twimg.com/profile_images/1583237430718697472/58HiJ5OO_400x400.jpg"),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              constraints: const BoxConstraints(maxWidth: 150),
                              child: AppText(
                                text: user.shopModel.data!.user!.username ??
                                    user.shopModel.data!.shop!.name ??
                                    "username",
                                color: HexColor("#475467"),
                                fontWeight: FontWeight.w600,
                                size: 16,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SizedBox(
                              child:
                                  SvgPicture.asset("assets/icon/settings.svg")),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(
                height: 24,
              ),
              ListTile(
                onTap: () => PageRouting.removePreviousToPage(
                    context, const HomeScreen()),
                title: AppText(
                  text: "Home",
                  color: drawerText,
                  fontWeight: FontWeight.w400,
                  size: 16,
                ),
                leading: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: HexColor("#475467"),
                      border: Border.all(color: HexColor("#475467"))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      "assets/icon/home.svg",
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ListTile(
                onTap: () => {
                  Operations.cleaarSearch(context),
                  OrderController.getOrderInitData(context),
                  PageRouting.removePreviousToPage(context, const OrderScreen())
                },
                title: AppText(
                  text: "Orders",
                  color: drawerText,
                  fontWeight: FontWeight.w400,
                  size: 16,
                ),
                leading: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: HexColor("#F2F4F7"),
                      border: Border.all(color: HexColor("#F2F4F7"))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      "assets/icon/order.svg",
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ListTile(
                onTap: () async {
                  Operations.cleaarSearch(context);
                  PageRouting.removePreviousToPage(
                      context, const DraftScreen());
                },
                title: AppText(
                  text: "Drafts",
                  color: drawerText,
                  fontWeight: FontWeight.w400,
                  size: 16,
                ),
                leading: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: HexColor("#F2F4F7"),
                      border: Border.all(color: HexColor("#F2F4F7"))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      "assets/icon/draft.svg",
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ListTile(
                onTap: () => logoutDialogu(
                    context,
                    "Are you sure you want to logout?",
                    "Logout",
                    "assets/icon/exit.svg",
                    red),
                title: AppText(
                  text: "Logout",
                  color: drawerText,
                  fontWeight: FontWeight.w400,
                  size: 16,
                ),
                leading: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: HexColor("#F2F4F7"),
                      border: Border.all(color: HexColor("#F2F4F7"))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      "assets/icon/exit.svg",
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
