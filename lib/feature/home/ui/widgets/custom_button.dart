import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String textButton;
  final IconData? iconButton;
  final void Function()? onPressed;
  const CustomButton({
    super.key, required this.textButton,  this.iconButton, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 59,
      width: 218,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 246, 115, 82))),
          onPressed:onPressed ,
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textButton,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              Visibility(
                visible: iconButton != null? true:false,
                child: Icon(
                  iconButton,
                  //Icons.keyboard_double_arrow_right
                  color: Colors.white,
                ),
              ),
              
            ],
          )),
    );
  }
}