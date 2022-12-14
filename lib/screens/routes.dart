import 'package:flutter/material.dart';
import 'package:flutter_tuts/screens/dogicon/sub_breeds.dart';
import 'package:flutter_tuts/screens/dogicon/favourites.dart';
import 'package:flutter_tuts/screens/dogicon/main.dart';
import 'package:flutter_tuts/screens/home.dart';
import 'package:flutter_tuts/screens/single/provider_app.dart';
import 'package:flutter_tuts/screens/users/main.dart';
import 'package:flutter_tuts/screens/users/register_user.dart';
import './single/show_open_apps.dart';
import './single/temperature_converter.dart';

class RouteGenerator {
  static Route goTo(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return goTo(const Home());
      case '/show-open-apps':
        return goTo(ShowOpenApps());
      case '/temperature-converter':
        return goTo(const TemperatureConverter());
      case '/users-register':
        return goTo(const UsersRegister());
      case '/user-register/add':
        return goTo(const RegisterUser());
      case '/provider-app':
        return goTo(const ProviderApp());
      case '/dogicon':
        return goTo(const DogiconApp());
      case '/dogicon/favourites':
        Object? fav = settings.arguments;
        if (fav is List) {
          return goTo(DogiconFavourites(fav));
        }
        return _errorRoute();
      case '/dogicon/sub-breeds':
        Object? breed = settings.arguments;
        if (breed is String) {
          return goTo(DogiconSubBreeds(breed));
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "404",
                  style: Theme.of(_)
                      .textTheme
                      .headline1
                      ?.copyWith(color: Colors.red),
                ),
                Text("You seem to be missing.",
                    style: Theme.of(_).textTheme.headline6),
                IconButton(
                  onPressed: () async {
                    Navigator.pop(_);
                  },
                  splashRadius: 25,
                  color: Colors.blue,
                  icon: const Icon(Icons.navigate_before),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
