import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';


void myShowToast(msg) {
  // Fluttertoast.showToast(
  //     msg: msg,
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.CENTER,
  //     timeInSecForIosWeb: 1,
  //     backgroundColor: Colors.red,
  //     textColor: Colors.white,
  //     fontSize: 16.0
  // );
  showToast(msg,
      textStyle: const TextStyle(fontSize: 25, color: Colors.white),
      duration: const Duration(milliseconds: 700)
  );
}

Widget getButton(onPressed, context, str) {
  final width = MediaQuery.of(context).size.width / 5.2;
  return OutlinedButton(
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3.0),
      ),
      padding: EdgeInsets.fromLTRB(width, 0, width, 0),
      // side: const BorderSide(width: 1)
    ),
    child: Text(str)
  );
}