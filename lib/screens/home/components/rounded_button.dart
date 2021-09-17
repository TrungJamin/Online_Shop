import 'package:flutter/material.dart';
import 'package:online_shop_udemy/consts/colors.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    this.onPressed,
    this.title,
    this.icon,
    this.color,
  }) : super(key: key);
  final Function? onPressed;
  final String? title;
  final IconData? icon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(color: ColorsConsts.backgroundColor),
            ),
          )),
      onPressed: () {
        onPressed!();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title!,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
          ),
          SizedBox(
            width: 5,
          ),
          Icon(
            icon,
            size: 18,
          )
        ],
      ),
    );
  }
}
