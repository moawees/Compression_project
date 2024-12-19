import 'package:comp/core/router/app_router.dart';
import 'package:comp/core/router/routes.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CompApp extends StatelessWidget {
   CompApp({super.key,required this.appRouter});
  AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      onGenerateRoute: appRouter.generateRoute,
      
    );
  }
}