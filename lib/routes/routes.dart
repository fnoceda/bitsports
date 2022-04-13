import 'package:bitsports/features/home/models/custom_people_model.dart';
import 'package:bitsports/features/home/pages/home_page.dart';
import 'package:bitsports/features/home/pages/page_404.dart';
import 'package:bitsports/features/home/pages/person_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return _fadeRoute(HomePage(), '/home');
      case '/detail':
        return _fadeRoute(
            PersonDetailPage(
              person: settings.arguments as CustomPeopleModel,
            ),
            '/detail');

      default:
        return _fadeRoute(Page404(), '/404');
    }
  }

  static PageRoute _fadeRoute(Widget child, String routeName) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => child,
      transitionsBuilder: (_, animation, __, ___) => (kIsWeb)
          ? FadeTransition(
              opacity: animation,
              child: child,
            )
          : CupertinoPageTransition(
              primaryRouteAnimation: animation,
              secondaryRouteAnimation: __,
              linearTransition: true,
              child: child,
            ),
      settings: RouteSettings(name: routeName),
    );
  }
}
