import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/create_transaction/bloc/create_transaction_cubit.dart';
import 'package:flutter_app/presentation/create_transaction/view/create_transaction_view.dart';
import 'package:flutter_app/presentation/login/bloc/login_cubit.dart';
import 'package:flutter_app/presentation/login/view/login_view.dart';
import 'package:flutter_app/presentation/main/bloc/main_cubit.dart';
import 'package:flutter_app/presentation/main/view/main_view.dart';
import 'package:flutter_app/presentation/register/bloc/register_cubit.dart';
import 'package:flutter_app/presentation/splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register/view/register_view.dart';

class RouteList {
  static const String registerScreen = '/register';
  static const String loginScreen = '/login';
  static const String createTransaction = '/createTransaction';
  static const String main = '/main';
  static const String splash = '/splash';
}

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    // final _argument = settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case RouteList.registerScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => RegisterCubit(),
            child: const RegisterScreen(),
          ),
        );
      case RouteList.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginCubit(),
            child: const LoginScreen(),
          ),
        );
      case RouteList.main:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => TabMangerCubit(),
            child: const MainScreen(),
          ),
        );
      case RouteList.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case RouteList.createTransaction:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) => CreateTransactionCubit(),
              child: const TransactionScreenProvider()),
        );
      default:
        return _emptyRoute(settings);
    }
  }

  static MaterialPageRoute _emptyRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Center(
              child: Text(
                'Back',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        body: Center(
          child: Text('No path for ${settings.name}'),
        ),
      ),
    );
  }
}
