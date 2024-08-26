import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itunes/config/colors.dart';
import 'package:url_launcher/url_launcher.dart';

final navigatorKey = GlobalKey<NavigatorState>();

const TextStyle titleLabelStyle = TextStyle(
  color: Colors.black87,
  fontSize: 14,
  fontWeight: FontWeight.w900,
);

showLog(String msg) {
  debugPrint(msg);
}

showMessage(BuildContext context, String msg, {String type = "red"}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: type == "success" ? Colors.green : Colors.red,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Text(
        msg,
        textAlign: TextAlign.center,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    ),
  );
}

Future<void> showProgress(BuildContext context) async {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CupertinoActivityIndicator(
            radius: 20,
            color: ITunesColors.whiteColor,
          ),
        );
      });
}

Future<void> openUrl(url, context) async {
  if (!await launchUrl(url)) {
    showMessage(context, "Could not launch url!");
  }
}
