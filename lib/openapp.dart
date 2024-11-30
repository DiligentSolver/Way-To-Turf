import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:waytoturf/connected_page.dart';

import 'noconnectionpage.dart';

class OpenApp extends StatelessWidget {
  const OpenApp({super.key, required this.home});

  final Widget home;

  @override
  Widget build(BuildContext context) {
    return ConnectionNotifier(
      connectionNotificationOptions: const ConnectionNotificationOptions(
        alignment: Alignment.center,
        disconnectedConnectionNotification: NoInternetPage(),
        connectedConnectionNotification: ConnectedPage(),
      ),
      child: GetMaterialApp(
        home: home,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
