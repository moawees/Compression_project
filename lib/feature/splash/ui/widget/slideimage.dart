import 'package:flutter/material.dart';

class Slideimage extends StatelessWidget {
  const Slideimage({super.key, required this.slideAnimation});
    final Animation<Offset> slideAnimation;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slideAnimation,
      builder: (context,_){
        return SlideTransition(
        position: slideAnimation,
        child:  Image.asset("assets/image/logo.png")
      );   
      },
       
    );
  }
}