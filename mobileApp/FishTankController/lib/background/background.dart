import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Background extends StatelessWidget {
  final Widget child;
  Background({@required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -1 * size.height / 1.7,
            child: Container(
              height: size.height,
              width: size.width,
              child: SvgPicture.asset("assets/images/down.svg"),
            ),
          ),
          Positioned(
              bottom: -1 * size.height / 1.6,
              child: Container(
                height: size.height,
                width: size.width,
                child: SvgPicture.asset(
                  "assets/images/down.svg",
                ),
              )),
          Positioned(
            top: 30,
            child: SvgPicture.asset("assets/images/logo.svg"),
          ),
          this.child
        ],
      ),
    );
  }
}
