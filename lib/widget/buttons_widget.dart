import 'package:flutter/material.dart';

class TxtButton extends StatelessWidget {

  final void Function() onPressed;
  final Color color;
  final String text;
  final double horizontalPadding;
  final double verticalPadding;
  final double borderRadius;
  Color borderColor;

  TxtButton({Key key,
    this.onPressed,this.color,this.text,this.borderColor,
    this.horizontalPadding=0,this.verticalPadding=0,this.borderRadius = 30}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ButtonStyle buttonStyle = TextButton.styleFrom(
      primary: color,
      minimumSize: Size(88, 44),
      padding:EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: borderColor??color)
      ),
      backgroundColor: color,

    );

    return TextButton(
      child: Text(text, style: TextStyle(color: Colors.black,fontSize: 13.0),),
      style: buttonStyle,
      onPressed: onPressed,

    );
  }
}
