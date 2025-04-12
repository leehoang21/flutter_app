import 'package:flutter/material.dart';
import 'package:flutter_app/common/contant.dart';

import 'base_bloc.dart';

extension ContextExtension on BuildContext {
  void showSnackbar(
    String translationKey,
  ) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(translationKey,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            )),
      ),
    );
  }

  void showPopup(VoidCallback onSubmit, String title, Widget content) {
    showDialog(
      context: this,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              onPressed: () {
                onSubmit();
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<T?> push<T extends Object?>(
    String route,
  ) {
    return Navigator.of(this).pushNamed(
      route,
    );
  }

  Future<T?> replace<T extends Object?>(String route) {
    return Navigator.of(this).pushReplacementNamed(
      route,
    );
  }

  Future<T?> pushAndRemoveUntil<T extends Object?>(String route) {
    return Navigator.of(navigator.currentContext!).pushNamedAndRemoveUntil(
      route,
      (route) => false,
    );
  }

  Future<bool> pop<T extends Object?>(T? result) {
    return Navigator.of(this).maybePop(result);
  }
}

extension BaseBlocExtension on BaseBloc {
  void showSnackbar(
    String translationKey,
  ) {
    ScaffoldMessenger.of(navigator.currentContext!).showSnackBar(
      SnackBar(
        content: Text(translationKey,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            )),
      ),
    );
  }

  void showPopup(VoidCallback onSubmit, String title, Widget content) {
    showDialog(
      context: navigator.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              onPressed: () {
                onSubmit();
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<T?> push<T extends Object?>(
    String route,
  ) {
    return Navigator.of(navigator.currentContext!).pushNamed(
      route,
    );
  }

  Future<T?> replace<T extends Object?>(String route) {
    return Navigator.of(navigator.currentContext!).pushReplacementNamed(
      route,
    );
  }

  Future<T?> pushAndRemoveUntil<T extends Object?>(String route) {
    return Navigator.of(navigator.currentContext!).pushNamedAndRemoveUntil(
      route,
      (route) => false,
    );
  }

  Future<bool> pop<T extends Object?>(T? result) {
    return Navigator.of(navigator.currentContext!).maybePop(result);
  }
}
