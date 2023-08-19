import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:overlay_support/overlay_support.dart';
import 'package:salesapp/presentation/constant/colors.dart';
import 'package:salesapp/presentation/generalwidgets/text.dart';

Map _source = {ConnectivityResult.none: false};
final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
String string = '';

class CheckConnect {
  static Future networkCheck([bool? upload]) async {
    bool? isOnce;
    _networkConnectivity.initialise();
    _networkConnectivity.myStream.listen((source) async {
      try {
        _source = source;
        print('source $_source');
        final result = await InternetAddress.lookup('google.com');
        // 1.
        switch (_source.keys.toList()[0]) {
          case ConnectivityResult.mobile:
            string = _source.values.toList()[0]
                ? 'Mobile: Online'
                : 'Mobile: Offline';
            break;
          case ConnectivityResult.wifi:
            string =
                _source.values.toList()[0] ? 'WiFi: Online' : 'WiFi: Offline';
            break;
          case ConnectivityResult.none:
          default:
            string = 'Offline';
        }
        if ((string == "Mobile: Online" || string == "WiFi: Online") ||
            result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          // isOnce = false;

          if (upload == false) {
            if (isOnce != null) {
              showSimpleNotification(
                AppText(
                  text: "Connected",
                  color: white,
                ),
                contentPadding: const EdgeInsets.all(10),
                slideDismiss: true,
                leading: Container(
                  height: 32,
                  width: 32,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.transparent),
                  child: const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.wifi,
                        color: Colors.white,
                        size: 20,
                      )),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: AppText(
                    text: "Welcome back online.",
                    color: white,
                  ),
                ),
                elevation: 10,
                background: green.withOpacity(0.5),
                duration: const Duration(seconds: 5),
              );
            }
          } else {
         //   consoleLog("Since network is available we will upload all orders to server");
          }
        } else {
          if (upload == false) {
            isOnce = true;
            showSimpleNotification(
              AppText(
                text: "Network error",
                color: white,
              ),
              contentPadding: const EdgeInsets.all(10),
              slideDismiss: true,
              leading: Container(
                height: 32,
                width: 32,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.transparent),
                child: const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.wifi,
                      color: Colors.white,
                      size: 20,
                    )),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: AppText(
                  text: "All operations will be offline",
                  color: white,
                ),
              ),
              elevation: 10,
              background: blue.withOpacity(0.5),
              duration: const Duration(seconds: 5),
            );
          }
        }
      } on SocketException catch (_) {
        if (upload == false) {
          isOnce = true;
          showSimpleNotification(
            AppText(
              text: "Network error",
              color: white,
            ),
            contentPadding: const EdgeInsets.all(10),
            slideDismiss: true,
            leading: Container(
              height: 32,
              width: 32,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.transparent),
              child: const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.signal_wifi_connected_no_internet_4_outlined,
                    color: Colors.white,
                    size: 20,
                  )),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: AppText(
                text: "All operations will be offline",
                color: white,
              ),
            ),
            elevation: 10,
            background: blue.withOpacity(0.5),
            duration: const Duration(seconds: 5),
          );
        }
      }
    });
  }
}

class NetworkConnectivity {
  NetworkConnectivity._();
  static final _instance = NetworkConnectivity._();
  static NetworkConnectivity get instance => _instance;
  final _networkConnectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;
  // 1.
  void initialise() async {
    ConnectivityResult result = await _networkConnectivity.checkConnectivity();
    _checkStatus(result);
    _networkConnectivity.onConnectivityChanged.listen((result) {
    //  print(result);
      _checkStatus(result);
    });
  }

// 2.
  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();
}
