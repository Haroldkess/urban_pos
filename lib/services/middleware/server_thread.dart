import 'package:flutter/scheduler.dart';
import 'package:salesapp/services/controllers/order_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import '../controllers/network_controller.dart';

const taskName = "uploadOrder";

SharedPreferences? pref;

//initialize the workmanager for uploading order
initSyncWorker() async {
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  await Workmanager().registerPeriodicTask(taskName, taskName,
      frequency: const Duration(minutes: 15),
      constraints: Constraints(networkType: NetworkType.connected));
}

// call dispatcher to triger the order upload function
callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    orderUpload;
    return Future.value(true);
  });
}

orderUpload() {
//  print("Since network is available we will upload all orders to server");

  OrderController.atemptLogin(null);
}
