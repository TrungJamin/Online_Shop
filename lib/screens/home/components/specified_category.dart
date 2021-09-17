import 'package:flutter/material.dart';

class SpecifiedCategory extends StatelessWidget {
  const SpecifiedCategory({
    Key? key,
    required this.name,
    required this.imgSrc,
  }) : super(key: key);
  final String name;
  final String imgSrc;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 190,
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10))),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10)),
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(imgSrc))),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                name,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    // ignore: deprecated_member_use
                    color: Theme.of(context).textSelectionColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
