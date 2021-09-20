import 'package:flutter/material.dart';

class Components {
  static Widget error(String e) {
    return Container(
      child: Center(
        child: Text(e),
      ),
    );
  }

  static Widget loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
