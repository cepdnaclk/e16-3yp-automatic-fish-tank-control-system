import 'package:flutter/material.dart';

class SideBarItem extends StatelessWidget {
  final IconData iconData;
  final String itemName;
  final Function ontap;
  final Color color;

  SideBarItem(
      {@required this.iconData, @required this.itemName, @required this.ontap,@required this.color});

  void onTap(){

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              this.iconData,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              this.itemName,
              style: TextStyle(
                  color: this.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
