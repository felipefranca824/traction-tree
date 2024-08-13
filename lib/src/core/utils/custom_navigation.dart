import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

sealed class CustomNavigator {
  /// Navigate to a new screen.
  /// This action replaces all past routes.
  ///
  /// ```
  /// Modular.to.navigate('/home');
  /// ```
  static void navigate(String path, {dynamic arguments}) {
    return Modular.to.navigate(path, arguments: arguments);
  }

  /// Navigate to a route.
  ///
  /// ```
  /// Modular.to.pushNamed('/home/10');
  /// ```
  /// You could give parameters
  /// ```
  /// Modular.to.pushNamed('/home', arguments: 10);
  /// ```
  static Future<T?> pushNamed<T extends Object?>(
    String name, {
    Object? arguments,
    bool forRoot = false,
  }) {
    return Modular.to.pushNamed(name, arguments: arguments, forRoot: forRoot);
  }

  ///Replace the current route of the navigator that most tightly encloses the
  ///given context by pushing the route named routeName and then disposing the
  ///previous route once the new route has finished animating in.
  ///
  /// ```
  /// Modular.to.pushReplacementNamed('/home/10');
  /// ```
  /// You could give parameters
  /// ```
  /// Modular.to.pushReplacementNamed('/home', arguments: 10);
  /// ```

  static Future<T?> pushReplacementNamed<T extends Object?>(
    String name, {
    Object? arguments,
    bool forRoot = false,
  }) {
    return Modular.to
        .pushReplacementNamed(name, arguments: arguments, forRoot: forRoot);
  }

  /// Push the route with the given name onto the navigator that most tightly
  /// encloses the given context, and then remove all the previous routes until
  /// the predicate returns true.
  ///
  /// ```
  /// Modular.to.pushNamedAndRemoveUntil('/home/10', ModalRoute.withName('/'));
  /// ```
  /// You could give parameters
  /// ```
  /// Modular.to.pushNamedAndRemoveUntil('/home', ModalRoute.withName('/'), arguments: 10);
  /// ```
  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String name,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
    bool forRoot = false,
  }) {
    return Modular.to.pushNamedAndRemoveUntil(name, predicate,
        arguments: arguments, forRoot: forRoot);
  }

  static void pop([dynamic result]) {
    return Modular.to.pop(result);
  }

  static void popUntil(bool Function(Route<dynamic>) predicate) {
    return Modular.to.popUntil(predicate);
  }

  /// Pop the current route off the navigator and navigate to a route.
  ///
  /// ```
  /// Modular.to.popAndPushNamed('/home');
  /// ```
  /// You could give parameters
  /// ```
  /// Modular.to.popAndPushNamed('/home', arguments: 10);
  /// ```
  static Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
    String name, {
    TO? result,
    Object? arguments,
    bool forRoot = false,
  }) {
    return Modular.to.popAndPushNamed(name,
        result: result, arguments: arguments, forRoot: forRoot);
  }

  static bool canPop() => Modular.to.canPop();
}
