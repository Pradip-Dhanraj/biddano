import 'package:flutter/material.dart';

Widget activityindicator() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Center(
        child: CircularProgressIndicator(),
      ),
      SizedBox(height: 10),
      Text('loading data...')
    ],
  );
}
