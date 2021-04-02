
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenericIconButton extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final Icon icon;
  final Function onTap;

  GenericIconButton({this.height, this.width, this.color = Colors.black12, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Material(
          color: color,
          child:InkWell(
            child: icon,
            onTap: onTap,
          )),
    );
  }
}