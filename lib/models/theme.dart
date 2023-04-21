import 'package:flutter/material.dart';

const aHintTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.bold
);

const aLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final aBoxDecorationStyle = BoxDecoration(
  color: Colors.black54,

  borderRadius: BorderRadius.circular(10.0),
  boxShadow: const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);