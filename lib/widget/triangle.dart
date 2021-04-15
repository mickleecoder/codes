

import 'package:flutter/material.dart';

class TriangleWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  TriangleWidget({@required this.width,@required this.height,this.color});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TriangleClipper(),
      child: Container(
        color: color,
        height: height,
        width: width,
      ),
    );
  }
}



class TriangleClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0.0, size.height/2);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}