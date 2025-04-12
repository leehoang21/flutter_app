import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/routes.dart';

import '../common/contant.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigator,
        initialRoute: RouteList.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
