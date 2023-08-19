import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/presentation/generalwidgets/banner.dart';
import 'package:salesapp/presentation/generalwidgets/loader.dart';
import 'package:salesapp/services/controllers/login_controller.dart';
import 'package:salesapp/services/controllers/operations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/temps/temp_store.dart';
import '../../constant/colors.dart';
import '../../functions/allNavigation.dart';
import '../../generalwidgets/button.dart';
import '../../generalwidgets/form_field.dart';
import '../../generalwidgets/text.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController id = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    // child: Image.asset(
                    //   "asset/pic/splash.png",
                    //   fit: BoxFit.fitWidth,
                    // ),
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: white,
                  )
                ],
              )),
          Container(
            width: double.infinity,
            height: double.infinity,
            //  color: Colors.amber,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        AppText(
                          text: "Welcome to",
                          color: blue,
                          size: 27,
                          align: TextAlign.center,
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        AppText(
                          text: "Ogaboss!",
                          color: blue,
                          size: 36,
                          align: TextAlign.center,
                          fontWeight: FontWeight.w800,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: AppText(
                            text: "For Vendors",
                            color: blue.withOpacity(.7),
                            size: 14,
                            align: TextAlign.center,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Row(
                      children: [
                        AppText(
                          text: "Login",
                          color: blue,
                          size: 16,
                          align: TextAlign.center,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AppFormField2(
                            hint: 'Mobile Number',
                            color: white.withOpacity(0.2),
                            prefixIcon: "assets/icon/number.svg",
                            hintColor: blue.withOpacity(0.4),
                            borderColor: blue,
                            svgColor: blue,
                            isNumber: true,
                            controller: phone,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppFormField2(
                            hint: 'Password',
                            color: white.withOpacity(0.2),
                            prefixIcon: "assets/icon/Lock.svg",
                            hintColor: blue.withOpacity(0.4),
                            borderColor: blue,
                            svgColor: blue,
                            isNumber: false,
                            controller: pass,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppFormField2(
                            hint: 'ShopId',
                            color: white.withOpacity(0.2),
                            prefixIcon: "assets/icon/draft.svg",
                            hintColor: blue.withOpacity(0.4),
                            borderColor: blue,
                            svgColor: blue,
                            isNumber: false,
                            controller: id,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const SizedBox(
                      height: 39,
                    ),
                    isLoading
                        ? Loader(
                            color: blue,
                          )
                        : MyButton(
                            onTap: () {
                              _submit(context);
                            },
                            height: 56,
                            backColor: blue,
                            child: AppText(
                              text: "Login",
                              color: white,
                              size: 18,
                              align: TextAlign.center,
                              fontWeight: FontWeight.w700,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _submit(BuildContext context) async {
    LoginProvider login = Provider.of(context, listen: false);
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    } else {
      if (phone.text.isEmpty || pass.text.isEmpty || id.text.isEmpty) {
        showBanner("Incomplete Form ", red, context);
        return;
      } else {
       await login.addDetails(id.text, phone.text, pass.text);

        SharedPreferences pref = await SharedPreferences.getInstance();
        setState(() {
          isLoading = true;
        });
        try {
          if (phone.text == pref.getString(TempStore.phoneKey) &&
              pass.text == pref.getString(TempStore.passwordKey) &&
              id.text == pref.getString(TempStore.shopIdKey)) {
            // ignore: use_build_context_synchronously
            LoginController.makeRequest(context);
          } else {
            await pref
                .clear()
                .whenComplete(() => LoginController.makeRequest(context));
          }
        } catch (e) {
          debugPrint(e.toString());
          setState(() {
            isLoading = false;
          });
        }

        setState(() {
          isLoading = false;
        });

        // ignore: use_build_context_synchronously

      }
    }
    _formKey.currentState?.save();
  }
}
