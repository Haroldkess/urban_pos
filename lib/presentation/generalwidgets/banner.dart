import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:salesapp/presentation/constant/colors.dart';
import 'package:salesapp/presentation/generalwidgets/text.dart';

void showBanner(String msg, Color color, BuildContext context) {
  showToast(msg,
      context: context,
      backgroundColor: color,
      fullWidth: true,
      position: StyledToastPosition.top);
}

inAppSnackBar(context, message, [bool? isError, VoidCallback? tap]) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: AppText(text: message),
    elevation: 3.0,
    duration: const Duration(minutes: 1),
    backgroundColor: isError == true ? red : blue,
    behavior: SnackBarBehavior.floating,
    action: tap != null
        ? SnackBarAction(
            onPressed: tap,
            label: 'Sync Now',
            textColor: Colors.black,
          )
        : null,
  ));
}
