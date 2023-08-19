import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:salesapp/services/controllers/cart_controller.dart';
import 'package:salesapp/services/controllers/category_controller.dart';
import 'package:salesapp/services/controllers/customer_controller.dart';
import 'package:salesapp/services/controllers/login_controller.dart';
import 'package:salesapp/services/controllers/network_controller.dart';
import 'package:salesapp/services/controllers/order_controller.dart';
import 'package:salesapp/services/controllers/product_controller.dart';
import 'package:salesapp/services/controllers/shop_settings_controller.dart';

import '../presentation/uiproviders/ui_provider.dart';

class InitProvider {
  static List<SingleChildWidget> providerInit() {
    final List<SingleChildWidget> provided = [
      ChangeNotifierProvider(
        create: (context) => UiProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => LoginProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ProductProvider(),
      ),
      // ChangeNotifierProvider(
      //   create: (context) => NetworkProvider(),
      // ),
        ChangeNotifierProvider(
        create: (context) => CategoryProvider(),
      ),
          ChangeNotifierProvider(
        create: (context) => CartProvider(),
      ),
             ChangeNotifierProvider(
        create: (context) => OrderProvider(),
      ),
          ChangeNotifierProvider(
        create: (context) => ShopSettingsProvider(),
      ),
         ChangeNotifierProvider(
        create: (context) => CustomerProvider(),
      ),
    ];

    return provided;
  }
}
