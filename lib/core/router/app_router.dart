import 'package:comp/core/router/routes.dart';
import 'package:comp/feature/home/ui/home.dart';
import 'package:comp/feature/splash/ui/splash.dart';
import 'package:flutter/material.dart';

class AppRouter {

  Route ?generateRoute(RouteSettings settings){
    switch(settings.name){
      case Routes.splash:
      return MaterialPageRoute(
        builder: (_)=>Splash()
        );

      case Routes.home:
      return MaterialPageRoute(
        builder: (_)=> Home()
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child:Text("'No route defined for ${settings.name}'") ,),),);
    }
  
  }





}