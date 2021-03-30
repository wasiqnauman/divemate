import 'package:flutter/material.dart';

Widget floatingButton(Function _fun, String _img) {
  /*
    @params
    _fun: onPressed function of button
    _img: path to image for button text

    @returns
    a FloatingActionButton widget

    */

  return FloatingActionButton.extended(
    backgroundColor: const Color(0xffa9cfd8),
    foregroundColor: Colors.black,
    onPressed: _fun,
    label: RichText(
      text: TextSpan(children: [
        WidgetSpan(
          child: Icon(Icons.add, size: 24,),
        ),
        WidgetSpan(
          child: ImageIcon(AssetImage(_img), size: 24,),
        ),
      ]),
    ),
  );
}


