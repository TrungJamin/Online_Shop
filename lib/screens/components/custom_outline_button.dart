import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton({
    Key? key,
    this.imgUrl,
    this.title,
    this.highlightedBorderColor,
    this.borderColor,
    this.shape,
    this.titleColor,
    this.onPressed,
  }) : super(key: key);
  final String? imgUrl;
  final String? title;
  final Color? highlightedBorderColor;
  final Color? borderColor;
  final ShapeBorder? shape;
  final Color? titleColor;
  final Function? onPressed;
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: () {
        onPressed!();
      },
      shape: shape,
      highlightedBorderColor: highlightedBorderColor,
      borderSide: BorderSide(width: 2, color: borderColor!),
      child: Row(
        children: [
          Image.asset(
            imgUrl!,
            width: 20,
            height: 20,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title!,
            style: TextStyle(
              color: titleColor,
            ),
          ),
        ],
      ),
    );
  }
}
