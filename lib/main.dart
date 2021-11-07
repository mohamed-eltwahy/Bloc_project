import 'package:flutter/material.dart';

import 'helper/app_router.dart';

void main() {
  runApp(MyApp(
    router: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter? router;
  const MyApp({Key? key, required this.router}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router!.generateRoute,
      theme: ThemeData(
        fontFamily: 'Cairo',
      ),
    );
  }
}
