import 'package:flutter/material.dart';

class AuthDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Divider(
          color: Colors.black,
          thickness: 1,
        ),
      ),
    );
  }
}
