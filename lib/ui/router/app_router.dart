import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return null;
      // return MaterialPageRoute(builder: (_) => HomeView());
      default:
        return MaterialPageRoute(
          builder: (_) => Center(
            child: Scaffold(
              body: Center(
                child: Container(
                  child: Text(
                    '404 Not found',
                    style: TextStyle(fontSize: 28),
                  ),
                ),
              ),
            ),
          ),
        );
    }
  }
}
