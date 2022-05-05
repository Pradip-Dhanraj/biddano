import 'package:biddano/views/tabbar/api-implementation/api.dart';
import 'package:biddano/views/tabbar/dashboard.dart';
import 'package:biddano/views/tabbar/ui-credit-card/ui.dart';
import 'package:flutter/material.dart';

const String uiRoute = 'ui';
const String apiRoute = 'api';
const String dashboardRoute = 'dashboard';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case apiRoute:
      return MaterialPageRoute(
        builder: (context) => const APIPage(
          key: Key(apiRoute),
        ),
      );
    case uiRoute:
      return MaterialPageRoute(
        builder: (context) => const UIPage(
          key: Key(uiRoute),
        ),
      );
    default:
      return MaterialPageRoute(
          builder: (context) => const Dashboard(
                key: Key(dashboardRoute),
              ));
  }
}
