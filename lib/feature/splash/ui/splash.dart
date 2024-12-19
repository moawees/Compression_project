import 'package:comp/core/router/routes.dart';
import 'package:comp/feature/splash/ui/widget/slideimage.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;
  @override

  void initState() {
    super.initState();

    initSlidingAnimation();
    navigateToHome();
  }

  
  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Slideimage(slideAnimation: slideAnimation)),
    );
  }

  void initSlidingAnimation() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    slideAnimation = Tween<Offset>(begin: const Offset(0, 3), end: Offset.zero)
        .animate(animationController);
    animationController.forward();
  }

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 2),()
    { 
        Navigator.of(context).pushReplacementNamed(Routes.home);
     
    });
  }
}
