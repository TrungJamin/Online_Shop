import 'package:flutter/cupertino.dart';

class GetScreenSize {
  // avoid create an instance
  GetScreenSize._();
  static getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }
}
